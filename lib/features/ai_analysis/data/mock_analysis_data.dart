class MockAnalysisData {
  static const Map<String, dynamic> data = {
  "success": true,
  "status": "completed",
  "session_statistics": {
    "total_chunks_processed": 4,
    "total_processing_latency_sec": 14.852,
    "llm_report_latency_sec": 2.451
  },
  "detailed_timeline": [
    {
      "transcript": "أنا بقالي كام يوم مش عارف أنام خالص وحاسس بخنقة في صدري",
      "semantic_sentiment": "negative",
      "vocal_acoustic_emotion": "Low_Tired"
    },
    {
      "transcript": "كل ما أحاول أركز في الشغل بحس إن مفيش فايدة وكل حاجة بتبوظ",
      "semantic_sentiment": "negative",
      "vocal_acoustic_emotion": "Low_Tired"
    },
    {
      "transcript": "بس لما قعدت مع أهلي امبارح اتكلمت معاهم وارتحت شوية صراحة",
      "semantic_sentiment": "positive",
      "vocal_acoustic_emotion": "Neutral"
    },
    {
      "transcript": "مش عارف ليه فجأة قمت متنرفز وزعقت في البيت كله من غير سبب محرز",
      "semantic_sentiment": "negative",
      "vocal_acoustic_emotion": "High_Intensity"
    }
  ],
  "clinical_insight_report": "### 1️⃣ ملخص الديناميكية النفسية العام\nيظهر المريض علامات واضحة للإحباط الإكلينيكي والانسحاب المزاجي، ممزوجة بنوبات مفاجئة من الهياج النفسي النفسي والسلوكي خلال فترات الضغط الحاد.\n\n### 2️⃣ تحليل منحنى الحالة المزاجية والطاقة الصوتية\nبدأت الجلسة بمؤشرات طاقة منخفضة (Low_Tired) ومزاج سلبي يعكس الإنهاك، ثم تحسنت المؤشرات مؤقتاً عند ذكر الدعم الأسري، قبل أن تنحرف حاداً نحو طاقة صوتية عالية (High_Intensity) تعكس حالة من عدم الاستقرار الانفعالي وثورة الغضب الفجائية.\n\n### 3️⃣ ملاحظات إكلينيكية وتوصيات للمعالج النفسي\nيُوصى بالتركيز على محفزات نوبات الغضب الفجائية، واستكشاف آليات الدعم الأسري كعامل حماية أساسي، مع ضرورة التركيز على تحسين جودة النوم لتفادي تدهور الطاقة الحيوية للمريض."
};
}