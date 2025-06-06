import 'dart:convert';

class AnakRequestModel {
    final String? noRing;
    final dynamic gambarBurung;
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final String? ayahNoRing;
    final String? ibuNoRing;

    AnakRequestModel({
        this.noRing,
        this.gambarBurung,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.ayahNoRing,
        this.ibuNoRing,
    });

    factory AnakRequestModel.fromJsonString(String str) => AnakRequestModel.fromMap(json.decode(str));

    String toJsonString() => json.encode(toMap());

    factory AnakRequestModel.fromMap(Map<String, dynamic> json) => AnakRequestModel(
        noRing: json["no_ring"],
        gambarBurung: json["gambar_burung"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        ayahNoRing: json["ayah_no_ring"],
        ibuNoRing: json["ibu_no_ring"],
    );

    Map<String, dynamic> toMap() => {
        "no_ring": noRing,
        "gambar_burung": gambarBurung,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "ayah_no_ring": ayahNoRing,
        "ibu_no_ring": ibuNoRing,
    };

    Map<String, dynamic> toJson() => toMap();
}
