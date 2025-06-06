import 'dart:convert';

class IndukRequestModel {
    final String? noRing;
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final dynamic keterangan;
    final String? gambarBurung;

    IndukRequestModel({
        this.noRing,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.keterangan,
        this.gambarBurung,
    });

    factory IndukRequestModel.fromJsonString(String str) => IndukRequestModel.fromMap(json.decode(str));

    String toJsonString() => json.encode(toMap());

    factory IndukRequestModel.fromMap(Map<String, dynamic> json) => IndukRequestModel(
        noRing: json["no_ring"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarBurung: json["gambar_burung"],
    );

    Map<String, dynamic> toMap() => {
        "no_ring": noRing,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "keterangan": keterangan,
        "gambar_burung": gambarBurung,
    };

    Map<String, dynamic> toJson() => toMap();
}
