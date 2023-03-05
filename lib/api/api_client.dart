import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_manager_rest_api/widgets/toast_message.dart';
import '../utility/utilites.dart';

var BaseUrl = 'https://task.teamrabbil.com/api/v1';
var RequestHeaders = {
  "Content-type": "application/json",
};

Future<bool> LoginRequest(FormValue) async {
  var URL = Uri.parse('${BaseUrl}/login');
  var PostBody = jsonEncode(FormValue);
  var response = await http.post(URL, headers: RequestHeaders, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    await WriteUserData(ResultBody);
    return true;
  } else {
    ErrorToast('Email or Password Wrong! Try Again');
    return false;
  }
}

Future<bool> RegistaionRequest(FormValue) async {
  var URL = Uri.parse('${BaseUrl}/registration');
  var PostBody = jsonEncode(FormValue);
  var response = await http.post(URL, headers: RequestHeaders, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async {
  var URL = Uri.parse('${BaseUrl}/RecoverVerifyEmail/${Email}');
  var response = await http.get(URL, headers: RequestHeaders);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    await WriteUserEmailVarification(Email);
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}

Future<bool> VerifyOTPlRequest(Email, OTP) async {
  var URL = Uri.parse('${BaseUrl}/RecoverVerifyOTP/${Email}/${OTP}');
  var response = await http.get(URL, headers: RequestHeaders);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    await WriteUserOTPVarification(OTP);
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}

Future<bool> SetPasswordRequest(FormValue) async {
  var URL = Uri.parse('${BaseUrl}/RecoverResetPass');
  var PostBody = jsonEncode(FormValue);
  var response = await http.post(URL, headers: RequestHeaders, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Request Success');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}

Future<List> ListTaskRequest(Status) async {
  var URL = Uri.parse('${BaseUrl}/ListTaskByStatus/${Status}');
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {
    "Content-type": "application/json",
    'token': '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    // SuccessToast('Request Success');
    return ResultBody['data'];
  } else {
    ErrorToast('Request Faild! Try Again');
    return [];
  }
}

Future <bool> AddNewTaskRequest(FormValue) async {
  var URL = Uri.parse('${BaseUrl}/createTask');
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {
    "Content-type": "application/json",
    'token': '$token'
  };
  var PostBody = jsonEncode(FormValue);
  var response = await http.post(URL, headers: RequestHeaderWithToken, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('New Task Added Successfully');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}

Future <bool> DeleteTaskRequest(id) async {
  var URL = Uri.parse('${BaseUrl}/deleteTask/${id}');
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {
    "Content-type": "application/json",
    'token': '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Delete Successful');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}


Future <bool> changeTaskStatueUpdateRequest(id, status) async {
  var URL = Uri.parse('${BaseUrl}/updateTaskStatus/${id}/${status}');
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {
    "Content-type": "application/json",
    'token': '$token'
  };
  var response = await http.get(URL, headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = jsonDecode(response.body);
  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast('Delete Successful');
    return true;
  } else {
    ErrorToast('Request Faild! Try Again');
    return false;
  }
}