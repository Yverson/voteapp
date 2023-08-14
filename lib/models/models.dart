
// To parse this JSON data, do
//
//     final commandes = commandesFromJson(jsonString);

import 'dart:convert';

class BureauVotes {
  BureauVotes({
    required this.Id,
    required this.Campagnes,
    required this.Tours,
    required this.Centres,
    required this.Description,
    required this.Etat,
    required this.Created,
    required this.Modified,
    required this.Status,
    required this.CampagnesId,
    required this.ToursId,
    required this.EntreprisesId,
    required this.Utilisateurs,
    required this.CentresId,
    required this.Commune,
    required this.No,
    required this.Hommes,
    required this.Femmes,
    required this.Total,
    required this.HommesIns,
    required this.FemmesIns,
    required this.TotalIns,
  });
  late final String Id;
  late final String Campagnes;
  late final String Tours;
  late final String Centres;
  late final String LocationBvs;
  late final String Description;
  late final String Etat;
  late final String Created;
  late final String Modified;
  late final String Status;
  late final String CampagnesId;
  late final String ToursId;
  late final String EntreprisesId;
  late final String Utilisateurs;
  late final String CentresId;
  late final String Commune;
  late final String No;
  late final int Hommes;
  late final int Femmes;
  late final int Total;
  late final int HommesIns;
  late final int FemmesIns;
  late final int TotalIns;

  BureauVotes.fromJson(Map<String, dynamic> json){
    Id = json['Id'];
    Campagnes = json['Campagnes'];
    Tours = json['Tours'];
    Centres = json['Centres'];
    LocationBvs = json['LocationBvs'];
    Description = json['Description'];
    Etat = json['Etat'];
    Created = json['Created'];
    Modified = json['Modified'];
    Status = json['Status'] != null ? json['Status'] : "";
    CampagnesId = json['CampagnesId'];
    ToursId = json['ToursId'];
    EntreprisesId = json['EntreprisesId'];
    Utilisateurs = json['Utilisateurs'];
    CentresId = json['CentresId'];
    Commune = json['Commune'] != null ? json['Commune'] : "";
    No = json['No'];
    Hommes = json['Hommes'] != null ? json['Hommes'] : 0;
    Femmes = json['Femmes'] != null ? json['Femmes'] : 0;
    Total = json['Total'] != null ? json['Total'] : 0;
    HommesIns = json['HommesIns'] != null ? json['HommesIns'] : 0;
    FemmesIns = json['HommesIns'] != null ? json['HommesIns'] : 0;
    TotalIns = json['TotalIns'] != null ? json['TotalIns'] : 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = Id;
    _data['Description'] = Description;
    _data['Etat'] = Etat;
    _data['Created'] = Created;
    _data['Modified'] = Modified;
    _data['Status'] = Status;
    _data['CampagnesId'] = CampagnesId;
    _data['ToursId'] = ToursId;
    _data['EntreprisesId'] = EntreprisesId;
    _data['Utilisateurs'] = Utilisateurs;
    _data['CentresId'] = CentresId;
    _data['Commune'] = Commune;
    _data['No'] = No;
    _data['Hommes'] = Hommes;
    _data['Femmes'] = Femmes;
    _data['Total'] = Total;
    return _data;
  }
}

class Candidats {
  Candidats({
    required this.id,
    required this.description,
    required this.etat,
    required this.created,
    required this.modified,
    required this.campagnesId,
    required this.toursId,
    required this.entreprisesId,
    required this.noms,
    required this.partie,
    required this.Photo,
  });
  late final String id;
  late final String description;
  late final String etat;
  late final String created;
  late final String modified;
  late final String campagnesId;
  late final String toursId;
  late final String entreprisesId;
  late final String noms;
  late final String partie;
  late final String Photo;

  Candidats.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    description = json['Description'];
    etat = json['Etat'];
    created = json['Created'];
    modified = json['Modified'];
    entreprisesId = json['EntreprisesId'];
    noms = json['Noms'];
    partie = json['Partie'];
    Photo = json['Photo'] != null ? json['Photo'] : "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['description'] = description;
    _data['etat'] = etat;
    _data['created'] = created;
    _data['modified'] = modified;
    _data['campagnesId'] = campagnesId;
    _data['toursId'] = toursId;
    _data['entreprisesId'] = entreprisesId;
    _data['noms'] = noms;
    _data['partie'] = partie;
    return _data;
  }
}

class Votes {
  Votes();
  late final String id;
  late final String description;
  late final String etat;
  late final DateTime created;
  late final DateTime modified;
  late final String status;
  late final String campagnesId;
  late final String toursId;
  late final String entreprisesId;
  late final String utilisateurs;
  late final String candidatsId;
  late final int quantite;
  late final String typeVotes;
  late final String centresId;
  late final String bureauVotesId;
  late final String typeOperations;
  late final String sexe;
  late final String Photo;

  Votes.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    description = json['Description'];
    etat = json['Etat'];
    created = DateTime.parse(json['Created']);
    modified = DateTime.parse(json['Modified']);
    campagnesId = json['CampagnesId'];
    toursId = json['ToursId'];
    utilisateurs = json['Utilisateurs'];
    candidatsId = json['CandidatsId'];
    quantite = json['Quantite'];
    typeVotes = json['TypeVotes'];
    centresId = json['CentresId'];
    bureauVotesId = json['BureauVotesId'];
    typeOperations = json['TypeOperations'];
    sexe = json['Sexe'] != null ? json['Sexe'] : "";
    Photo = json['Photo'] != null ? json['Photo'] : "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['description'] = description;
    _data['quantite'] = quantite;
    _data['typeVotes'] = typeVotes != null ? typeVotes : "";
    _data['candidatsId'] = candidatsId != null ? candidatsId : null;
    _data['typeOperations'] = typeOperations;
    return _data;
  }
}

class VotesTaux {
  VotesTaux();
  late final String id;
  late final String description;
  late final String etat;
  late final String created;
  late final String modified;
  late final String status;
  late final String campagnesId;
  late final String toursId;
  late final String entreprisesId;
  late final String utilisateurs;
  late final String candidatsId;
  late final int quantite;
  late final String typeVotes;
  late final String centresId;
  late final String bureauVotesId;
  late final String typeOperations;
  late final String sexe;

  VotesTaux.fromJson(Map<String, dynamic> json){
    id = json['id'];
    description = json['description'];
    etat = json['etat'];
    created = json['created'];
    modified = json['modified'];
    status = json['status'];
    campagnesId = json['campagnesId'];
    toursId = json['toursId'];
    entreprisesId = json['entreprisesId'];
    utilisateurs = json['utilisateurs'];
    candidatsId = json['candidatsId'];
    quantite = json['quantite'];
    typeVotes = json['typeVotes'];
    centresId = json['centresId'];
    bureauVotesId = json['bureauVotesId'];
    typeOperations = json['typeOperations'];
    sexe = json['sexe'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['description'] = description;
    _data['quantite'] = quantite;
    _data['typeOperations'] = typeOperations;
    _data['sexe'] = sexe != null ? sexe : "";
    return _data;
  }
}

class TypeIncidents {
  TypeIncidents();
  late final String id;
  late final String description;
  late final String etat;
  late final DateTime created;
  late final DateTime modified;
  late final String commentaire;
  late final String entreprisesId;

  TypeIncidents.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    description = json['Description'];
    etat = json['Etat'];
    created = DateTime.parse(json['Created']);
    modified = DateTime.parse(json['Modified']);
    commentaire = json['Commentaire'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['description'] = description;
    _data['commentaire'] = commentaire != null ? commentaire : "";
    return _data;
  }
}

class Incidents {
  Incidents();
  late final String id;
  late final String description;
  late final String commentaire;

  Incidents.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    description = json['Description'];
    commentaire = json['Commentaire'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['description'] = description;
    _data['Commentaire'] = commentaire;
    return _data;
  }
}

class Documents {
  Documents();
  late final String id;
  late final String description;
  late final String nom;
  late final String observation;
  late final String documents;
  late final String type;

  Documents.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    description = json['Description'];
    documents = json['Documents1'] != null ? json['Documents1']  : "";
    nom = json['Nom'];
    observation = json['Observation'] != null ? json['Observation']  : "";
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['Description'] = description;
    _data['Observation'] = observation;
    _data['Nom'] = nom;
    return _data;
  }
}