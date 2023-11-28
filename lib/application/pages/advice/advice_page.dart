import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/application/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/application/pages/advice/bloc/advicer_bloc.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_clean_architecture/application/pages/advice/widgets/error_message.dart';
import 'package:flutter_clean_architecture/injection.dart';
import 'package:provider/provider.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerBloc>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advicer",
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(child: BlocBuilder<AdvicerBloc, AdvicerState>(
              builder: (context, state) {
                if (state is AdvicerInitial) {
                  return Text(
                    "Your advice is waiting for you.",
                    style: themeData.textTheme.displayLarge,
                  );
                } else if (state is AdvicerStateLoading) {
                  return CircularProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  );
                } else if (state is AdvicerStateLoaded) {
                  return AdviceField(
                    advice: state.advice,
                  );
                } else if (state is AdvicerStateError) {
                  return ErrorMessage(
                    message: state.message,
                  );
                } else {
                  return const ErrorMessage(
                    message: "Oops! Something went wrong.",
                  );
                }
              },
            ))),
            const SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
