using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnitTestApp
{
    [Binding]
    class AddRecordsToTheTableSteps
    {
        [StepDefinition("fields displayed in the table")]
        public void VerifyValuesInForm()
        {

        }
        [Test]
        public void EnterValidValueToTheTable(Table tableValue)
        {
            NavigateToTestPage();
            SetValueInForm();
            VerifyValueInTable();
        }
    }
}
