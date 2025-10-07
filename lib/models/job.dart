class Job {
  final int id;
  final String title;
  final String company;
  final String location;
  final String description;
  final double salary;
  final String thumbnail;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.salary,
    required this.thumbnail,
  });

  factory Job.fromApi(Map<String, dynamic> m) {
    return Job(
      id: m['id'] ?? 0,
      title: m['title'] ?? 'No Title',
      company: m['brand'] ?? 'Company',
      location: m['category'] ?? 'Remote',
      description: m['description'] ?? '',
      salary: (m['price'] is num) ? (m['price'].toDouble()) : 0.0,
      thumbnail: m['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'company': company,
    'location': location,
    'description': description,
    'salary': salary,
    'thumbnail': thumbnail,
  };

  factory Job.fromJson(Map<String, dynamic> m) {
    return Job(
      id: m['id'] ?? 0,
      title: m['title'] ?? '',
      company: m['company'] ?? '',
      location: m['location'] ?? '',
      description: m['description'] ?? '',
      salary: (m['salary'] is num) ? m['salary'].toDouble() : 0.0,
      thumbnail: m['thumbnail'] ?? '',
    );
  }
}
