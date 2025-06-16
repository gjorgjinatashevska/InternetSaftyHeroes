import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const InternetSafetyHeroes());
}

class InternetSafetyHeroes extends StatelessWidget {
  const InternetSafetyHeroes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet Safety Heroes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        fontFamily: 'Comic Sans MS',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.orange,
          background: Colors.lightBlue[50],
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }
//-----do tuka za home page------
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.security,
                    size: 120,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Internet Safety Heroes",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Learn to be safe online!",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.blue[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Internet Safety Heroes"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shield,
                        size: 80,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Welcome to Internet Safety Heroes!",
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Learn how to stay safe online through fun quizzes!",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildCategoryCard(
                      context,
                      "Online Behavior",
                      Icons.thumb_up,
                      Colors.green,
                      QuizCategory.onlineBehavior,
                    ),
                    _buildCategoryCard(
                      context,
                      "Privacy & Security",
                      Icons.lock,
                      Colors.orange,
                      QuizCategory.privacySecurity,
                    ),
                    _buildCategoryCard(
                      context,
                      "Cyberbullying",
                      Icons.message,
                      Colors.red,
                      QuizCategory.cyberbullying,
                    ),
                    _buildCategoryCard(
                      context,
                      "Digital Footprint",
                      Icons.fingerprint,
                      Colors.purple,
                      QuizCategory.digitalFootprint,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.emoji_events),
                label: const Text("View Achievements"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AchievementsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      QuizCategory category,
      ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizIntro(category: category),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizIntro extends StatelessWidget {
  final QuizCategory category;

  const QuizIntro({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = getCategoryTitle(category);
    String description = getCategoryDescription(category);
    Color color = getCategoryColor(category);
    IconData icon = getCategoryIcon(category);

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: 80,
                        color: color,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.help_outline),
                          const SizedBox(width: 5),
                          Text(
                            "8 questions",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.timer),
                          const SizedBox(width: 5),
                          Text(
                            "15 seconds per question",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start Quiz"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(category: category),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final QuizCategory category;

  const QuizScreen({Key? key, required this.category}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 15;
  Timer? timer;
  late List<Question> questions;
  bool answerSelected = false;
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    questions = getQuestionsForCategory(widget.category);
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    setState(() {
      timeLeft = 15;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          moveToNextQuestion();
        }
      });
    });
  }

  void checkAnswer(int selectedIndex) {
    timer?.cancel();
    setState(() {
      answerSelected = true;
      selectedAnswerIndex = selectedIndex;
      if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      moveToNextQuestion();
    });
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        answerSelected = false;
        selectedAnswerIndex = null;
      });
      startTimer();
    } else {
      // Save score to shared preferences
      saveQuizResult();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: questions.length,
            category: widget.category,
          ),
        ),
      );
    }
  }

  Future<void> saveQuizResult() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'category_${widget.category.toString()}';
    final highScore = prefs.getInt(key) ?? 0;
    if (score > highScore) {
      await prefs.setInt(key, score);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final categoryColor = getCategoryColor(widget.category);

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(getCategoryTitle(widget.category)),
        backgroundColor: categoryColor,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "Score: $score",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question ${currentQuestionIndex + 1}/${questions.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: timeLeft > 5 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            "$timeLeft sec",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(categoryColor),
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        if (question.imagePath != null)
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  question.imagePath!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                question.questionText,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                question.options.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: answerSelected
                            ? index == question.correctAnswerIndex || selectedAnswerIndex == index
                            ? Colors.white
                            : Colors.black
                            : Colors.black, backgroundColor: answerSelected
                            ? index == question.correctAnswerIndex
                            ? Colors.green
                            : selectedAnswerIndex == index
                            ? Colors.red
                            : Colors.white
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: answerSelected ? null : () => checkAnswer(index),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: answerSelected
                                    ? index == question.correctAnswerIndex
                                    ? Colors.green[700]
                                    : selectedAnswerIndex == index
                                    ? Colors.red[700]
                                    : categoryColor.withOpacity(0.2)
                                    : categoryColor.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: TextStyle(
                                    color: answerSelected
                                        ? index == question.correctAnswerIndex || selectedAnswerIndex == index
                                        ? Colors.white
                                        : categoryColor
                                        : categoryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            if (answerSelected)
                              Icon(
                                index == question.correctAnswerIndex
                                    ? Icons.check_circle
                                    : selectedAnswerIndex == index
                                    ? Icons.cancel
                                    : null,
                                color: index == question.correctAnswerIndex
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                          ],
                        ),
                      ),
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

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final QuizCategory category;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;
    String message;
    Color messageColor;
    IconData messageIcon;

    if (percentage >= 80) {
      message = "Excellent! You're an Internet Safety Hero!";
      messageColor = Colors.green;
      messageIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      message = "Good job! You're learning well!";
      messageColor = Colors.blue;
      messageIcon = Icons.thumb_up;
    } else {
      message = "Keep practicing! You'll get better!";
      messageColor = Colors.orange;
      messageIcon = Icons.refresh;
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Quiz Results"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        messageIcon,
                        size: 80,
                        color: messageColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: messageColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: score / totalQuestions,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                percentage >= 80
                                    ? Colors.green
                                    : percentage >= 60
                                    ? Colors.blue
                                    : Colors.orange,
                              ),
                              strokeWidth: 12,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "$score/$totalQuestions",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${percentage.toInt()}%",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        getCategoryTitle(category),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Category: ${getCategoryTitle(category)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.replay),
                    label: const Text("Try Again"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(category: category),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text("Home"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Map<QuizCategory, int> scores = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  Future<void> loadScores() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      scores = {
        QuizCategory.onlineBehavior:
        prefs.getInt('category_${QuizCategory.onlineBehavior.toString()}') ?? 0,
        QuizCategory.privacySecurity:
        prefs.getInt('category_${QuizCategory.privacySecurity.toString()}') ?? 0,
        QuizCategory.cyberbullying:
        prefs.getInt('category_${QuizCategory.cyberbullying.toString()}') ?? 0,
        QuizCategory.digitalFootprint:
        prefs.getInt('category_${QuizCategory.digitalFootprint.toString()}') ?? 0,
      };
      isLoading = false;
    });
  }

  int getTotalScore() {
    return scores.values.fold(0, (sum, score) => sum + score);
  }

  String getAchievementLevel() {
    final totalScore = getTotalScore();
    if (totalScore >= 28) return "Master Internet Safety Hero";
    if (totalScore >= 20) return "Advanced Internet Safety Hero";
    if (totalScore >= 12) return "Internet Safety Apprentice";
    return "Internet Safety Beginner";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Achievements"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 60,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        getAchievementLevel(),
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total score: ${getTotalScore()}/32",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: getTotalScore() / 32,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildCategoryScoreCard(
                      QuizCategory.onlineBehavior,
                      "Online Behavior",
                      Icons.thumb_up,
                      Colors.green,
                    ),
                    _buildCategoryScoreCard(
                      QuizCategory.privacySecurity,
                      "Privacy & Security",
                      Icons.lock,
                      Colors.orange,
                    ),
                    _buildCategoryScoreCard(
                      QuizCategory.cyberbullying,
                      "Cyberbullying",
                      Icons.message,
                      Colors.red,
                    ),
                    _buildCategoryScoreCard(
                      QuizCategory.digitalFootprint,
                      "Digital Footprint",
                      Icons.fingerprint,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryScoreCard(
      QuizCategory category,
      String title,
      IconData icon,
      Color color,
      ) {
    final score = scores[category] ?? 0;
    final percentage = (score / 8) * 100;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Score: $score/8",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: score / 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${percentage.toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enum for quiz categories
enum QuizCategory {
  onlineBehavior,
  privacySecurity,
  cyberbullying,
  digitalFootprint,
}

// Class for question data
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? imagePath;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.imagePath,
  });
}

// Helper functions for category information
String getCategoryTitle(QuizCategory category) {
  switch (category) {
    case QuizCategory.onlineBehavior:
      return "Online Behavior";
    case QuizCategory.privacySecurity:
      return "Privacy & Security";
    case QuizCategory.cyberbullying:
      return "Cyberbullying";
    case QuizCategory.digitalFootprint:
      return "Digital Footprint";
  }
}

String getCategoryDescription(QuizCategory category) {
  switch (category) {
    case QuizCategory.onlineBehavior:
      return "Learn how to behave properly and safely online. What actions are okay and what should be avoided?";
    case QuizCategory.privacySecurity:
      return "Discover how to protect your personal information and stay secure while using the internet.";
    case QuizCategory.cyberbullying:
      return "Learn about cyberbullying, how to recognize it, and what to do if you experience or witness it.";
    case QuizCategory.digitalFootprint:
      return "Understand what digital footprints are and how the things you do online can stay there forever.";
  }
}

Color getCategoryColor(QuizCategory category) {
  switch (category) {
    case QuizCategory.onlineBehavior:
      return Colors.green;
    case QuizCategory.privacySecurity:
      return Colors.orange;
    case QuizCategory.cyberbullying:
      return Colors.red;
    case QuizCategory.digitalFootprint:
      return Colors.purple;
  }
}

IconData getCategoryIcon(QuizCategory category) {
  switch (category) {
    case QuizCategory.onlineBehavior:
      return Icons.thumb_up;
    case QuizCategory.privacySecurity:
      return Icons.lock;
    case QuizCategory.cyberbullying:
      return Icons.message;
    case QuizCategory.digitalFootprint:
      return Icons.fingerprint;
  }
}

// Questions data for each category
List<Question> getQuestionsForCategory(QuizCategory category) {
  switch (category) {
    case QuizCategory.onlineBehavior:
      return [
        Question(
          questionText: "Is it okay to use only your first name when creating a username?",
          options: ["Yes, first names are fine to use", "No, never use any part of your real name", "Yes, but only if you add numbers", "It depends on the website"],
          correctAnswerIndex: 3,
          // imagePath: "assets/images/username.png",
        ),
        Question(
          questionText: "Is it appropriate to share someone else's photo without their permission?",
          options: ["Yes, if it's a nice photo", "No, you should always ask first", "Yes, if they're your friend", "Only if they won't find out"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/sharing_photo.png",
        ),
        Question(
          questionText: "What should you do if a game asks for your home address?",
          options: ["Give it so you can win prizes", "Make up a fake address", "Ask your parents first", "Never provide your home address"],
          correctAnswerIndex: 3,
          // imagePath: "assets/images/address_form.png",
        ),
        Question(
          questionText: "Is it okay to download free music from any website?",
          options: ["Yes, if it says it's free", "No, it might be illegal or contain viruses", "Yes, everyone does it", "Only if your friends recommend it"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/download_music.png",
        ),
        Question(
          questionText: "If someone is mean to you online, you should:",
          options: ["Be mean back to them", "Ignore them and tell a trusted adult", "Keep it a secret", "Create a fake account to get revenge"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/cyberbullying.png",
        ),
        Question(
          questionText: "Is it okay to meet someone in person that you only know from the internet?",
          options: ["Yes, if they seem nice", "No, never meet internet friends", "Only if you've video chatted first", "Only with a parent or trusted adult"],
          correctAnswerIndex: 3,
          // imagePath: "assets/images/meeting.png",
        ),
        Question(
          questionText: "When playing online games with voice chat, you should:",
          options: ["Share your real name with everyone", "Use a nickname and be respectful", "Talk about personal things", "Share your address with teammates"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/gaming.png",
        ),
        Question(
          questionText: "What should you do if a website asks for your birthday?",
          options: ["Always give your real birthday", "Make up a fake birthday", "Ask a parent if it's safe", "Never answer birthday questions"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/birthday.png",
        ),
      ];
    case QuizCategory.privacySecurity:
      return [
        Question(
          questionText: "What makes a good password?",
          options: ["Your name and birth year", "A random mix of letters, numbers, and symbols", "The same password for all accounts", "Your pet's name"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/password.png",
        ),
        Question(
          questionText: "Is it safe to use public Wi-Fi for banking or shopping?",
          options: ["Yes, all Wi-Fi is secure", "Only if the network has a password", "No, public Wi-Fi is not secure for sensitive activities", "Only if you're quick"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/public_wifi.png",
        ),
        Question(
          questionText: "What should you do if a website asks to remember your password?",
          options: ["Always allow it", "Only on your personal device", "Never allow it", "Allow it on all devices"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/remember_password.png",
        ),
        Question(
          questionText: "What does a padlock icon in your browser mean?",
          options: ["The website is locked and you need permission", "The website is using a secure connection", "The website has blocked you", "The website contains games"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/padlock.png",
        ),
        Question(
          questionText: "Is it okay to click on links in emails from unknown senders?",
          options: ["Yes, if the email looks interesting", "Only if there are no spelling mistakes", "No, they could be dangerous", "Only if they offer prizes"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/email_link.png",
        ),
        Question(
          questionText: "What is two-factor authentication?",
          options: ["Having two passwords", "Using two devices", "An extra security step beyond just a password", "Logging in twice"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/two_factor.png",
        ),
        Question(
          questionText: "What should you do with old accounts you don't use anymore?",
          options: ["Leave them active", "Delete them", "Change the password to something simple", "Share them with friends"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/old_accounts.png",
        ),
        Question(
          questionText: "Who should you share your passwords with?",
          options: ["Your best friends", "Anyone who asks", "Your parents or guardians only", "Everyone in your family"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/share_password.png",
        ),
      ];
    case QuizCategory.cyberbullying:
      return [
        Question(
          questionText: "What is cyberbullying?",
          options: ["Using computers at school", "Being mean or hurtful online", "Playing online games", "Sharing funny videos"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/cyberbullying_definition.png",
        ),
        Question(
          questionText: "If you see someone being bullied online, you should:",
          options: ["Join in so you don't become a target", "Ignore it, it's not your problem", "Support the person and tell a trusted adult", "Take screenshots to share with friends"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/witness_bullying.png",
        ),
        Question(
          questionText: "Is it bullying to exclude someone from an online group?",
          options: ["No, you can choose your friends", "Yes, if it's done to hurt them", "Only if they find out", "Only if multiple people do it"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/exclusion.png",
        ),
        Question(
          questionText: "What should you do if someone posts an embarrassing photo of you?",
          options: ["Post an embarrassing photo of them", "Never go online again", "Ask them to remove it and tell an adult if needed", "Create a fake account to comment on it"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/embarrassing_photo.png",
        ),
        Question(
          questionText: "Is it okay to say things online that you wouldn't say in person?",
          options: ["Yes, online is different", "No, be respectful everywhere", "Yes, if you use a fake name", "Only if you're anonymous"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/online_comments.png",
        ),
        Question(
          questionText: "What can happen to cyberbullies?",
          options: ["Nothing, online bullying isn't serious", "They could face school discipline or legal consequences", "They'll get more friends", "They'll become famous"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/consequences.png",
        ),
        Question(
          questionText: "What is 'flaming' in online communication?",
          options: ["Sending lots of compliments", "Posting about fire safety", "Sending hostile messages", "Sharing information quickly"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/flaming.png",
        ),
        Question(
          questionText: "Is it cyberbullying to disagree with someone's opinion online?",
          options: ["Yes, you should always agree", "No, respectful disagreement is okay", "Only if you use capital letters", "Only if others join in"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/disagreement.png",
        ),
      ];
    case QuizCategory.digitalFootprint:
      return [
        Question(
          questionText: "What is a digital footprint?",
          options: ["A computer virus", "The traces you leave online", "A type of computer mouse", "A way to measure screen time"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/digital_footprint.png",
        ),
        Question(
          questionText: "Can you completely erase your digital footprint?",
          options: ["Yes, by deleting all your accounts", "No, once something is online it can be impossible to completely remove", "Yes, if you ask the internet company", "Only if you're under 13"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/erase_footprint.png",
        ),
        Question(
          questionText: "Who might look at your social media in the future?",
          options: ["No one, it's private", "Only your current friends", "Future employers, schools, or friends", "Only people who follow you"],
          correctAnswerIndex: 2,
          // imagePath: "assets/images/future_viewers.png",
        ),
        Question(
          questionText: "Is it okay to post photos of your friends without asking?",
          options: ["Yes, if they look good", "No, you should always ask permission", "Yes, if you're in the photo too", "Only on private accounts"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/friend_photos.png",
        ),
        Question(
          questionText: "What could happen if you share your location online?",
          options: ["Nothing, it's just data", "People might know where you live or go to school", "You'll get more followers", "Your phone will work better"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/location_sharing.png",
        ),
        Question(
          questionText: "Can deleted posts or messages ever be recovered?",
          options: ["No, once deleted they're gone forever", "Yes, they might have been saved or screenshot", "Only by computer experts", "Only within 24 hours"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/deleted_posts.png",
        ),
        Question(
          questionText: "Is it a good idea to post about going on vacation while you're away?",
          options: ["Yes, share your experiences", "No, it tells people your house is empty", "Only if you have a house sitter", "Only if you don't share your address"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/vacation_posts.png",
        ),
        Question(
          questionText: "What information is usually part of your digital footprint?",
          options: ["Only what you intentionally share", "Posts, comments, photos, likes, and searches", "Only public posts", "Only your name and birthday"],
          correctAnswerIndex: 1,
          // imagePath: "assets/images/footprint_components.png",
        ),
      ];
  }
}