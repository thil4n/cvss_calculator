Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        ScoreCircle(),
        MetricSectionCard(title: "Exploitability"),
        MetricSectionCard(title: "Impact"),
        VectorDisplay(),
      ],
    ),
  ),
);