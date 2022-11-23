// See https://aka.ms/new-console-template for more information
using System;

public class C2CParse
{
    public static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Need filename as arg");
            return;
        }

        string[] inputLatencies = null;
        string[] outputLatencies = null;
        string inputFile = File.ReadAllText(args[0]);
        string[] inputLines = inputFile.Split('\n');
        for (int row = 0; row < inputLines.Length; row++)
        {
            string[] lineSplit = inputLines[row].Split(',');
            if (inputLatencies == null)
            {
                inputLatencies = new string[inputLines.Length * lineSplit.Length];
                outputLatencies = new string[inputLines.Length * lineSplit.Length];
                if (inputLines.Length != lineSplit.Length)
                {
                    Console.WriteLine("Line count: {0}, line segments: {1} must be equal", inputLines.Length, lineSplit.Length);
                    return;
                }
            }

            for (int i = 0; i < inputLines.Length; i++)
            {
                inputLatencies[row * lineSplit.Length + i] = lineSplit[i];
            }
        }

        for (int row = 0; row < inputLines.Length; row++)
        {
            for (int col = 0; col < inputLines.Length; col++)
            {
                string v1 = inputLatencies[row * inputLines.Length + col];
                // translate both row and col
                int newRow = GetCoreIndex(row, 4, 64);
                int newCol = GetCoreIndex(col, 4, 64);
                outputLatencies[newRow * inputLines.Length + newCol] = v1;
            }
        }

        for (int row = 0; row < inputLines.Length; row++)
        {
            for (int col = 0; col < inputLines.Length; col++)
            {
                Console.Write(",{0}", outputLatencies[row * inputLines.Length + col]);
            }

            Console.WriteLine();
        }
    }

    /// <summary>
    /// Convert linux index to windows index
    /// </summary>
    /// <param name="inputIndex"></param>
    /// <param name="smtCount"></param>
    /// <param name="coreCount"></param>
    /// <returns></returns>
    public static int GetCoreIndex(int inputIndex, int smtCount, int coreCount)
    {
        int physicalCoreIndex = inputIndex % coreCount;
        int smtIndex = inputIndex / coreCount;
        return physicalCoreIndex * smtCount + smtIndex;
    }
}