using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AsmGen
{
    public class BranchHistoryTest : UarchTest2D
    {
        public string Prefix { get; private set; }

        public string Description => throw new NotImplementedException();

        public int[] XCounts => throw new NotImplementedException();

        public int[] YCounts => throw new NotImplementedException();

        public string FunctionDefinitionParameters => throw new NotImplementedException();

        public string GetFunctionCallParameters => throw new NotImplementedException();

        public bool DivideTimeByCount => throw new NotImplementedException();

        public BranchHistoryTest()
        {
            Prefix = "branchhist";
        }

        public void GenerateArmAsm(StringBuilder sb)
        {
            throw new NotImplementedException();
        }

        public void GenerateX86GccAsm(StringBuilder sb)
        {
            throw new NotImplementedException();
        }

        public void GenerateX86NasmAsm(StringBuilder sb)
        {
            throw new NotImplementedException();
        }
    }
}
