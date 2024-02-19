import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/core.dart';
import '../../../../common/common.dart';
import '../../presentation.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SharedPrefClient sharedPrefClient = SharedPrefClient.instance;

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isChecked = false;

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
        debugPrint('Masuk Sini 1');
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan Finger Print yang terdaftar di perangkat anda',
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Masuk dengan Sidik Jari',
            cancelButton: 'Batal',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
        debugPrint('Success Auth');
        context.read<SignInBloc>().add(
              const SignInWithNIKAndPassword(
                nik: 'SYN10',
                password: 'SYN10',
              ),
            );
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login to Synapsis',
                style: FontsGlobal.semiBoldTextStyle24,
              ),
              const VerticalSeparator(height: 2),
              Text(
                'Email',
                style: FontsGlobal.regulerTextStyle16.copyWith(
                  color: ColorConstant.greyTextColor,
                ),
              ),
              const VerticalSeparator(height: 0.5),
              PrimaryTextField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textEditingController: emailTextController,
              ),
              const VerticalSeparator(height: 2),
              Text(
                'Password',
                style: FontsGlobal.regulerTextStyle16.copyWith(
                  color: ColorConstant.greyTextColor,
                ),
              ),
              const VerticalSeparator(height: 0.5),
              PrimaryTextField(
                hintText: 'Password',
                obscureText: true,
                textEditingController: passwordTextController,
                suffixIcon: true,
              ),
              const VerticalSeparator(height: 1),
              //remember me
              Row(
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'Remember me',
                    style: FontsGlobal.regulerTextStyle14,
                  ),
                ],
              ),
              const VerticalSeparator(height: 2),
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  debugPrint('state SignInBloc : $state');
                  if (state is SignInSuccess) {
                    saveNIKPassword();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListAssessmentScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    text: 'Log in',
                    onPressed: () {
                      context.read<SignInBloc>().add(
                            SignInWithNIKAndPassword(
                              nik: emailTextController.text,
                              password: passwordTextController.text,
                            ),
                          );
                    },
                  );
                },
              ),
              const VerticalSeparator(height: 2),
              Center(child: Text('or', style: FontsGlobal.regulerTextStyle14)),
              const VerticalSeparator(height: 2),
              SecoundaryButton(
                text: 'Fingerprint',
                onPressed: () {
                  _authenticateWithBiometrics();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveNIKPassword() {
    if (isChecked) {
      sharedPrefClient.saveKey(
        key: SharedPrefKey.authEmail,
        data: emailTextController.text,
      );
      sharedPrefClient.saveKey(
        key: SharedPrefKey.authPassword,
        data: passwordTextController.text,
      );
    } else {
      sharedPrefClient.removeKey(key: SharedPrefKey.authEmail);
      sharedPrefClient.removeKey(key: SharedPrefKey.authPassword);
    }
  }

  void getDataRememberMe() {
    sharedPrefClient.getByKey(key: SharedPrefKey.authEmail).then((value) {
      emailTextController.text = value ?? '';
      setState(() {
        isChecked = true;
      });
    });
    sharedPrefClient.getByKey(key: SharedPrefKey.authPassword).then((value) {
      passwordTextController.text = value ?? '';
    });
  }
}
