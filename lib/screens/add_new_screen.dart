import 'package:expenz_app/services/income_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expense_model.dart';

class AddNewScreen extends StatefulWidget {
  final Function(ExpenseModel) addExpense;
  final Function(IncomeModel) addIncome;
  const AddNewScreen({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to track the expense or income
  int _selectedMethod = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.Food;
  IncomeCategory _incomeCategory = IncomeCategory.Salary;

  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controlers for the text from feilds
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  //selected date
  DateTime _selectedDate = DateTime.now();
  //selected date
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //expense and income toggle
              Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethod == 0 ? kBlue : null,
                          ),
                          child: Center(
                            child: Text(
                              "Expense",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethod == 1 ? kBlue : null,
                          ),
                          child: Center(
                            child: Text(
                              "Income",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //amount show area
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How much?",
                        style: TextStyle(
                          fontSize: 18,
                          color: kLightGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(
                            fontSize: 80,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 75,
                          color: kWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //form
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.31,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        //category select dropdown
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: kGrey, width: 1),
                            ),
                          ),
                          items: _selectedMethod == 0
                              ? ExpenseCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList()
                              : IncomeCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                          value: _selectedMethod == 0
                              ? _expenseCategory
                              : _incomeCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedMethod == 0
                                  ? _expenseCategory = value as ExpenseCategory
                                  : _incomeCategory = value as IncomeCategory;
                            });
                          },
                        ),
                        SizedBox(height: 15),
                        //title feild
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: kGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 2, color: kGrey),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //description feild
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            hintText: "Description",
                            hintStyle: TextStyle(
                              color: kGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 2, color: kGrey),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //amount feild
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            hintText: "Amount",
                            hintStyle: TextStyle(
                              color: kGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 2, color: kGrey),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //select date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  initialDate: DateTime.now(),
                                  context: context,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2026),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedDate = value;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: kMainColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.MMMMEEEEd().format(_selectedDate),
                              style: TextStyle(fontSize: 17, color: kGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        //select time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: kYellow,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.watch_later,
                                        color: kWhite,
                                        size: 30,
                                      ),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(_selectedTime),
                              style: TextStyle(fontSize: 17, color: kGrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(
                          color: kDividerColor,
                          thickness: 5,
                          radius: BorderRadius.circular(100),
                        ),
                        SizedBox(height: 15),
                        //Add button
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: GestureDetector(
                            onTap: () async {
                              if (_selectedMethod == 0) {
                                //save the expense/income save in shared preferenses
                                List<ExpenseModel> loadedExpenses =
                                    await ExpenseService().loadExpenses();

                                //create the expense to store
                                ExpenseModel expense = ExpenseModel(
                                  id: loadedExpenses.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                  category: _expenseCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );
                                //add expense
                                widget.addExpense(expense);

                                //clear the feilds
                                _titleController.clear();
                                _descriptionController.clear();
                                _amountController.clear();
                              
                              } else {
                                //save the expense/income save in shared preferenses
                                List<IncomeModel> loadedIncomes =
                                    await IncomeService().loadIncomes();

                                //create the expense to store
                                IncomeModel income = IncomeModel(
                                  id: loadedIncomes.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                  category: _incomeCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );
                                //add Income
                                widget.addIncome(income);

                                //clear the feilds
                                _titleController.clear();
                                _descriptionController.clear();
                                _amountController.clear();
                              
                              }
                            },
                            child: CustomButton(
                              btnName: "Add",
                              btnColor: _selectedMethod == 0 ? kRed : kGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
