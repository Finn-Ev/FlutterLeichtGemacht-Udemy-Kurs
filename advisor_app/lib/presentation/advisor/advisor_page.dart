import 'package:advisor_app/application/advisor/advice_bloc.dart';
import 'package:advisor_app/presentation/advisor/widgets/advice_field.dart';
import 'package:advisor_app/presentation/advisor/widgets/custom_button.dart';
import 'package:advisor_app/presentation/advisor/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvisorPage extends StatelessWidget {
  const AdvisorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advisor',
          style: themeData.textTheme.headline1,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdviceBloc, AdvisorState>(
                    bloc: BlocProvider.of<AdviceBloc>(context),
                    // ..add(AdviceRequestedEvent()),
                    builder: (context, state) {
                      if (state is AdviceLoadingState) {
                        return CircularProgressIndicator(
                          color: themeData.colorScheme.secondary,
                        );
                      } else if (state is AdviceLoadedState) {
                        return AdviceField(
                          state.text,
                        );
                      } else if (state is AdviceErrorState) {
                        return ErrorMessage(
                          message: state.message,
                        );
                      } else {
                        return const Text("Your advice is waiting for you!");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    onPressed: () => BlocProvider.of<AdviceBloc>(context).add(AdviceRequestedEvent()),
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
