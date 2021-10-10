using System.Collections.Generic;

namespace AsmGen
{
    public interface IUarchTestParallelBuild : IUarchTest
    {
        /// <summary>
        /// Generate and write out NASM files
        /// </summary>
        /// <returns>list of nasm filenames to include in build</returns>
        public List<string> GenerateNasmFiles();

    }
}
