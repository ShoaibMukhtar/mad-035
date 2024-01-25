using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;

namespace calculator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Mode_Click(object sender, RoutedEventArgs e)
        {
            if (r1.Visibility== Visibility.Hidden && r2.Visibility == Visibility.Hidden && r3.Visibility == Visibility.Hidden) {
                r1.Visibility = Visibility.Visible;
                r2.Visibility = Visibility.Visible;
                r3.Visibility = Visibility.Visible;
            }
            else
            {
                r1.Visibility = Visibility.Hidden;
                r2.Visibility = Visibility.Hidden;
                r3.Visibility = Visibility.Hidden;
            }

        }

        private void r1_Checked(object sender, RoutedEventArgs e)
        {
            b2.Visibility = Visibility.Visible;
            b3.Visibility = Visibility.Visible;
            b4.Visibility = Visibility.Visible;
            b5.Visibility = Visibility.Visible;
            b6.Visibility = Visibility.Visible;
            b7.Visibility = Visibility.Visible;
            b8.Visibility = Visibility.Visible;
            b9.Visibility = Visibility.Visible;






            


        }

        private void clear(object sender, RoutedEventArgs e)
        {
          /*  if(b1.Visibility==Visibility.Hidden|| b2.Visibility == Visibility.Hidden|| b3.Visibility == Visibility.Hidden|| b4.Visibility == Visibility.Hidden)
            {
                b1.Visibility = Visibility.Visible;
                b2.Visibility = Visibility.Visible;
                b3.Visibility = Visibility.Visible;
                b4.Visibility = Visibility.Visible;
                b5.Visibility = Visibility.Visible;
                b6.Visibility = Visibility.Visible;
                b7.Visibility = Visibility.Visible;
                b8.Visibility = Visibility.Visible;
                b9.Visibility = Visibility.Visible;
            }*/
            Input_block.Text = "";
            Result_block.Text = "";
        }

        private void r3_Checked(object sender, RoutedEventArgs e)
        {
            if (r3.IsChecked == true)
            {
                b8.Visibility = Visibility.Hidden;
                b9.Visibility = Visibility.Hidden;
                b6.Visibility = Visibility.Visible;
                b7.Visibility = Visibility.Visible;
                b5.Visibility = Visibility.Visible;
                b4.Visibility = Visibility.Visible;
                b3.Visibility = Visibility.Visible;
                b2.Visibility = Visibility.Visible;

            }
            else
            {
                b8.Visibility = Visibility.Visible;
                b9.Visibility = Visibility.Visible;
            }
        }

        private void r2_chk(object sender, RoutedEventArgs e)
        {
            if (r2.IsChecked == true)
            {
                b2.Visibility = Visibility.Hidden;
                b3.Visibility = Visibility.Hidden;
                b4.Visibility = Visibility.Hidden;
                b5.Visibility = Visibility.Hidden;
                b6.Visibility = Visibility.Hidden;
                b7.Visibility = Visibility.Hidden;
                b8.Visibility = Visibility.Hidden;
                b9.Visibility = Visibility.Hidden;

            }
        }

        private bool IsOperator(char c)
        {
            return c == '+' || c == '-' || c == '*' || c == '/';
        }

        private void ValidateAndAppendToInput(string text)
        {
            string inputText = Input_block.Text;
            if (text == "." && inputText.EndsWith("."))
            {
                // Do not allow double dots
                return;
            }
            else if (text == "." || !IsOperator(text[0]) || !IsOperator(inputText.LastOrDefault()))
            {
                Input_block.Text += text;
            }
            else
            {
                // Do not allow double operators
                Input_block.Text = inputText.Substring(0, inputText.Length - 1) + text;
            }
        }

        private void b1_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("1");
        }

        private void b2_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("2");
        }

        // Repeat the above pattern for other number buttons (b3_Click, b4_Click, ..., b9_Click) and dot button (dot_Click).

        private void Plus_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("+");
        }

        private void sub_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("-");
        }

        private void Mul_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("*");
        }

        private void Div_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("/");
        }

        private void b5_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("5");

        }

        private void b0_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("0");
        }



        private void b3_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("3");
        }

        private void b4_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("4");
        }

        private void b6_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("6");
        }

        private void b7_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("7");
        }

        private void b8_Click(object sender, RoutedEventArgs e)
        {
            Input_block.Text = Input_block.Text + "8";
        }

        private void b9_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("9");
        }

        private void dot_Click(object sender, RoutedEventArgs e)
        {
            Input_block.Text = Input_block.Text + ".";
        }


        delegate string EvaluateExpressionDelegate(string expression);
        private string _input;
        private string _result;

        public string Input
        {
            get { return _input; }
            set { _input = value; }
        }

        public string Result
        {
            get { return _result; }
            set { _result = value; }
        }
        private void Equal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (r2.IsChecked==true)
                {
                    string binaryExpression = Input_block.Text;

                    EvaluateExpressionDelegate binaryDelegate = EvaluateBinaryExpression;
                    IAsyncResult result = binaryDelegate.BeginInvoke(binaryExpression, null, null);

                    result.AsyncWaitHandle.WaitOne();


                    string binaryResult = binaryDelegate.EndInvoke(result);

                    Result_block.Text = binaryResult;
                }
                else if (r3.IsChecked == true)
                {
                    string octalExpression = Input_block.Text;

                    EvaluateExpressionDelegate octalDelegate = EvaluateOctalExpression;
                    IAsyncResult result = octalDelegate.BeginInvoke(octalExpression, null, null);

                    result.AsyncWaitHandle.WaitOne();

                    string octalResult = octalDelegate.EndInvoke(result);

                    Result_block.Text = octalResult;
                }
                else
                {
                    string expression = Input_block.Text.Replace("%", "/100");

                    EvaluateExpressionDelegate decimalDelegate = EvaluateDecimalExpression;
                    IAsyncResult result = decimalDelegate.BeginInvoke(expression, null, null);


                    result.AsyncWaitHandle.WaitOne();


                    string decimalResult = decimalDelegate.EndInvoke(result);

                    Result_block.Text = decimalResult;
                }
            }
            catch (Exception ex)
            {
                Input_block.Text = "Error";
            }
        }


        private string EvaluateDecimalExpression(string decimalExpression)
        {
            try
            {
                var dataTable = new DataTable();
                var result = dataTable.Compute(decimalExpression, "");

                return result.ToString();
            }
            catch (Exception ex)
            {
                return "Error";
            }
        }


        private string EvaluateBinaryExpression(string binaryExpression)
        {
            try
            {

                char operation = binaryExpression.FirstOrDefault(c => c == '+' || c == '-' || c == '*' || c == '/');

                if (operation != '\0')
                {

                    string[] operands = binaryExpression.Split(operation);

                    long operand1 = Convert.ToInt64(operands[0], 2);
                    long operand2 = Convert.ToInt64(operands[1], 2);


                    long result = 0;
                    switch (operation)
                    {
                        case '+':
                            result = operand1 + operand2;
                            break;
                        case '-':
                            result = operand1 - operand2;
                            break;
                        case '*':
                            result = operand1 * operand2;
                            break;
                        case '/':
                            if (operand2 != 0)
                                result = operand1 / operand2;
                            else
                                return "Error";
                            break;
                    }


                    return Convert.ToString(result, 2);
                }
                else
                {
                    return "Error";
                }
            }
            catch (Exception ex)
            {
                return "Error";
            }
        }

             private string EvaluateOctalExpression(string octalExpression)
        {
            try
            {

                octalExpression = octalExpression.Replace("%", "/100");


                char operatorChar = octalExpression.FirstOrDefault(c => c == '+' || c == '-' || c == '*' || c == '/');
                if (operatorChar != '\0')
                {
                    string[] operands = octalExpression.Split(operatorChar);


                    int operand1 = Convert.ToInt32(operands[0], 8);
                    int operand2 = Convert.ToInt32(operands[1], 8);


                    int result = 0;
                    switch (operatorChar)
                    {
                        case '+':
                            result = operand1 + operand2;
                            break;
                        case '-':
                            result = operand1 - operand2;
                            break;
                        case '*':
                            result = operand1 * operand2;
                            break;
                        case '/':
                            if (operand2 != 0)
                                result = operand1 / operand2;
                            else
                                return "Error: Division by zero";
                            break;
                    }


                    return Convert.ToString(result, 8);
                }
                else
                {

                    return octalExpression;
                }
            }
            catch (Exception ex)
            {
                return "Error";
            }
        }









        private void lock_Click(object sender, RoutedEventArgs e)
        {
            if(stack1.Visibility == Visibility.Hidden)
            {
                stack1.Visibility = Visibility.Visible;

            }

        }

        private void back_Click(object sender, RoutedEventArgs e)
        {


            if (Input_block.Text.Length > 0)
            {

                Input_block.Text = Input_block.Text.Remove(Input_block.Text.Length - 1, 1);
            }
        }

        private void unlock_Click(object sender, RoutedEventArgs e)
        {
            if(stack1.Visibility==Visibility.Visible)
            {
                stack1.Visibility = Visibility.Hidden;
            }
        }

        private void Modulus_Click(object sender, RoutedEventArgs e)
        {
            ValidateAndAppendToInput("%");
        }
    }

}
