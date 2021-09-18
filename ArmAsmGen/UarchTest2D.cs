using System.Text;

namespace AsmGen
{
    /// <summary>
    /// Uarch test that goes in two dimensions. For example, branch history
    /// </summary>
    public interface UarchTest2D
    {
        public string Prefix { get; }
        public string Description { get; }

        /// <summary>
        /// Test values going down the X (horizontal) axis
        /// </summary>
        public int[] XCounts { get; }
        
        /// <summary>
        /// Test values going down the Y (vertical) axis
        /// </summary>
        public int[] YCounts { get; }
        public string FunctionDefinitionParameters { get; }
        public string GetFunctionCallParameters { get; }
        public bool DivideTimeByCount { get; }
        public void GenerateX86GccAsm(StringBuilder sb);
        public void GenerateX86NasmAsm(StringBuilder sb);
        public void GenerateArmAsm(StringBuilder sb);
    }
}
