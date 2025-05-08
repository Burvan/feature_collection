part of extensions;

extension LocaleObserver on String {
  String watchTr(
      BuildContext context, {
        List<String>? args,
        Map<String, String>? namedArgs,
        String? gender,
      }) {
    context.locale;
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }
}