class ProgramModel {
  final String code; // e.g. "01" is deliberately NOT used — see note below
  final String name;
  final String tagline;
  final String description;
  final String imageUrl;
  final List<String> details;

  const ProgramModel({
    required this.code,
    required this.name,
    required this.tagline,
    required this.description,
    required this.imageUrl,
    required this.details,
  });
}

// Note: programs are not a sequence — a member doesn't do Strength, then
// Conditioning, then Open Floor in order — so cards are labelled with the
// floor area's shorthand (e.g. "FLOOR A") rather than 01/02/03, which would
// wrongly imply a required order.
