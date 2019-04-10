import argparse
import getpass
import grp
import os
import re
from subprocess import Popen, PIPE

parser = argparse.ArgumentParser(description="Main entry point "
                                             "for offline calibration")
parser.add_argument("--input", nargs='+')
parser.add_argument("--output", nargs=1)
parser.add_argument("--report-to", nargs=1)
parser.add_argument("--local-cal-store", nargs=1)
parser.add_argument("--mem-cells", type=int, nargs=1)
parser.add_argument("--cores", type=int, nargs=1, default=16)
parser.add_argument("--instance", nargs=1)
parser.add_argument("--type", nargs=1)
parser.add_argument("--rebuild",  default=False, action='store_true')
parser.add_argument("--nodes", nargs=1, default="2")
parser.add_argument("--slave",  default=False, action='store_true')
parser.add_argument("--docker-path", nargs=1, default="/gpfs/exfel/data/scratch/example_data/offline_cal.tar")

def create_balanced_filelist(file_list, nodes):
    # first find files from the same modules
    regex = r'.*-[a-z|A-Z]*([0-9]+)-.*'
    mod_ids = [re.findall(regex, os.path.basename(fn))[0] for fn in file_list]
    mod_ids = list(set(mod_ids))
    node_files = [None]*len(mod_ids)
    for i in range(len(mod_ids)):
        node_files[i] = []
    for file in file_list:
        mod_id = re.findall(regex, os.path.basename(file))[0]
        idx = mod_ids.index(mod_id)
        node_files[idx].append(file)
    max_len = 0
    for node_list in node_files:
        max_len = max(max_len, len(node_list))
    balanced = [None]*nodes
    for i in range(nodes):
        balanced[i] = []
    for i in range(max_len):
        for node_list in node_files:
            if i < len(node_list):
                balanced[i % nodes].append(node_list[i])

    return balanced


def run():
    args = vars(parser.parse_args())

    rtype = args["type"][0]
    instance = args["instance"][0]
    infiles = [os.path.abspath(i) for i in args["input"] if '.h5' in i]
    output = os.path.abspath(args["output"][0])
    if not os.path.exists(output):
        os.makedirs(output)
    report_dir = os.path.abspath(args["report_to"][0])
    cal_store = os.path.abspath(args["local_cal_store"][0])
    cal_path = os.path.dirname(os.path.abspath(args["local_cal_store"][0]))
    cells = args["mem_cells"][0]
    cores = args["cores"][0]
    maxwell = True
    nodes = int(args["nodes"][0])
    slave = bool(args["slave"])
    dp = args["docker_path"]
    if isinstance(dp, (list, tuple)):
        dp = dp[0]
    docker_path = os.path.abspath(dp)

    if not slave:
        balanced = create_balanced_filelist(infiles, nodes)
        print("Total input: {} files".format(len(infiles)))
        print("Balanced into {} nodes".format(nodes))
        for i, b in enumerate(balanced):
            print("Node {}: {} files".format(i, len(b)))
        infiles = balanced[0]
    else:
        infiles = infiles[0].split()
    # check if the docker image is installed

    dockers = []
    with Popen(["docker", "images", "--format", "{{.Repository}}"],
                stdout=PIPE) as proc:
        dockers = str(proc.stdout.read()).split("\\n")
        dockers = [str(d) for d in dockers]


    if not "offline_cal" in dockers:
        # build the docker file
        print("Loading offline calibration docker - this will take a while!")
#        Popen(["docker", "build", "-t", "offline_cal", "."]).wait()
        Popen(["docker", "load", "--input", docker_path]).wait()

    if not slave:

        for n in range(nodes-1):
            if len(balanced[n+1]) == 0:
                continue
            srun_cmd = ["srun", "-p", "upex", "python3", "calibrate.py"]
            srun_cmd += ["--input", " ".join(balanced[n+1])]
            srun_cmd += ["--output", output]
            srun_cmd += ["--report-to", report_dir]
            srun_cmd += ["--instance", instance]
            srun_cmd += ["--local-cal-store", cal_store]
            srun_cmd += ["--mem-cells", str(cells)]
            srun_cmd += ["--cores", str(cores)]
            srun_cmd += ["--docker-path", docker_path]
            srun_cmd += ["--slave"]
            srun_cmd += ["--type", rtype]
            Popen(srun_cmd)

    # now run the container
    run_cmd = ["docker",
               "run"]

    if maxwell:
        in_paths = set([os.path.dirname(f) for f in infiles])
        for path in in_paths:
            run_cmd += ["-v", "{}:/input{}".format(path, path)]
        infiles = ["/input/{}".format(f) for f in infiles]

        store_dir = os.path.dirname(os.path.abspath(cal_store))
        store_file = os.path.basename(os.path.abspath(cal_store))

        run_cmd += ["-v", "{}:/output".format(output),
                    "-v", "{}:/report".format(report_dir),
                    "-v", "{}:/cal_local/".format(store_dir),
                    "-u" "{}:{}".format(os.getuid(), os.getegid()),
                    "--userns=host", "--security-opt=no-new-privileges",
                    "offline_cal",
                    "--mem-cells", str(cells),
                    "--cores", str(cores),
                    "--type", str(rtype),
                    "--instance", str(instance),
                    "--input", " ".join(infiles),
                    "--output", "/output",
                    "--local-cal-store", "/cal_local/{}".format(store_file),
                    "--local-cal-path", "/cal_local/{}".format(os.path.relpath(store_dir, cal_path)),
                    "--report-to", "/report"]
   
    p = Popen(run_cmd)
    p.communicate()


if __name__ == "__main__":
    run()
