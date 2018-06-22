unit UnitGestion;

interface

uses GestionEcran, UnitMilitaire, UnitVille, System.SysUtils, UnitRecord,
  UnitAffichage, UnitSave;

procedure gestionCivilisation(var g: Game; var c: Civilisation);
// gere les actions a partir de l'ecran civilisation
procedure gestionAcceuil(var c: Char);
// gere les actions a partir du menu principal
procedure gestionSave (var g: Game; var cancel : Boolean);

implementation

procedure gestionMilitaire(var g: Game; var c: Civilisation);
var
  choix: Char; // caractere saisie par l'utilisateur
begin
  repeat
    choix := '&';
    afficheMilitaire(g, c);
    readln(choix);
    case choix of
      '1' .. '2':
        begin
          if c.recrutement > StrToInt(choix) - 1 then
          begin
            if choix = '1' then
            begin
              if c.ville.caserne > 0 then
                Recruter(c, StrToInt(choix))
              else
                messageGlobal := 'Aucune caserne';
            end;

            if choix = '2' then
            begin
              if c.ville.mine > 0 then
                Recruter(c, StrToInt(choix))
              else
                messageGlobal := 'Aucune mine';
            end;
          end
          else
          begin
            messageGlobal := 'Pas de point de recrutement';
          end;
        end;
      '3' .. '4':
        begin
          if c.soldat + c.canon > 0 then
          begin
            attaquerBarbare(g, c, StrToInt(choix) - 2);
          end
          else
          begin
            messageGlobal := 'Aucune troupe';
          end;
        end;
    end;
  until (choix = '0');
end;

procedure gestionVille(var g: Game; var v: ville);
var
  choix: Char; // caractere saisie par l'utilisateur
begin
  repeat
    afficheVille(g, v);
    readln(choix);

    if v.construction = -1 then
      v.construction := StrToInt(choix)
    else if (choix >='1') and (choix <='4') then
         
      messageGlobal := 'Impossible construction deja en cours';

  until (choix = '0');
end;

procedure gestionCivilisation(var g: Game; var c: Civilisation);
var
  choix: Char; // caractere saisie par l'utilisateur
  cancel : Boolean;
begin
  repeat
    choix := '&';
    cancel := false;
    afficheCivilisation(g, g.Civilisation);
    readln(choix);
    case choix of
      '1':
        gestionVille(g, g.Civilisation.ville);
      '2':
        gestionMilitaire(g, g.Civilisation);
      '0':
      begin
        g.fini := true;
        //save(g);
        //saveUneGame(g);
        gestionSave(g, cancel);
      end;
    end;
  until ((choix = '0') or (choix = '9')) and not cancel;
end;

procedure gestionAcceuil(var c: Char);
var
  choix: Char; // caractere saisie par l'utilisateur
begin
  afficheAccueil;
  readln(c);
end;

procedure gestionSave (var g: Game; var cancel : Boolean);
var
  choix : Char;
begin
  afficheSave;
  readln(choix);
  if choix = '1' then
  begin
    saveUneGame(g);
  end
  else if choix = '0' then
  begin
    g.fini := false;
    cancel := true;
  end;

end;

end.
