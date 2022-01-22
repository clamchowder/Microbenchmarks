using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace SimpleAffinitySetter
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("Must specify cores (comma separated), and executable");
                return;
            }

            string selectedCores = args[0];
            string[] selectedCoresArr = selectedCores.Split(',');
            ulong affinityMask = 0;
            foreach (string selectedCore in selectedCoresArr)
            {
                int core = int.Parse(selectedCore);
                affinityMask |= (1UL << core);
            }

            Console.WriteLine("Affinity mask: {0:X}", affinityMask);

            Process process = new Process();
            process.StartInfo = new ProcessStartInfo
            {
                FileName = args[1]
            };

            if (args.Length > 2) process.StartInfo.Arguments = args[3];
            process.Start();
            process.ProcessorAffinity = (IntPtr)affinityMask;
            Task.Run(() => RunMonitoringThread(process.StartInfo.FileName, affinityMask));
            process.WaitForExit();
        }

        public static async Task RunMonitoringThread(string processName, ulong affinityMask)
        {
            string friendlyName = Path.GetFileName(processName);
            friendlyName = friendlyName.Split('.')[0];
            while (true)
            {
                Process[] processes = Process.GetProcessesByName(friendlyName);
                Console.WriteLine("Process name {0} has {1} PIDs", friendlyName, processes.Count());
                foreach (Process process in processes)
                {
                    try
                    {
                        process.ProcessorAffinity = (IntPtr)affinityMask;
                        Console.WriteLine("Set affinity for PID {0}", process.Id);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Failed to set affinity for PID {0}: {1}", process.Id, e);
                    }
                }

                Thread.Sleep(2000);
            }
        }
    }
}
