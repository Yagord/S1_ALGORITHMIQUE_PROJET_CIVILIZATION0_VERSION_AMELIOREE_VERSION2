unit UnitSave;

interface

  uses unitRecord, UnitAffichage, GestionEcran;

  Procedure save (g : Game);

  Procedure load (var g : Game);

  Procedure saveUneGame (g : Game);

  Procedure loadUneGame (var g : Game);

implementation

  Procedure save (g : Game);
  Var
    f : file of Game;
  begin
    assign(f, 'dataGame.bin');
    rewrite(f);
    write(f, g);
    close(f);
  end;


  Procedure load (var g : Game);
  Var
    f : file of Game;
  begin
    assign(f, 'dataGame.bin');
    reset(f);
    read(f, g);
    close(f);
  end;


  Procedure saveUneGame (g : Game);
  Var
    f : file of Game;
    nomSave : String;
  begin
    deplacerCurseurXY(4,24);
    write('Nommmez votre sauvegarde : ');
    read(nomSave);

    assign(f, nomSave);
    rewrite(f);
    write(f, g);
    close(f);
  end;

  Procedure loadUneGame (var g : Game);
  Var
    f : file of Game;
    nomLoad : String;
  begin
    deplacerCurseurXY(4,28);
    write('Quelle sauvegarde chargez : ');
    read(nomLoad);

    assign(f, nomLoad);
    reset(f);
    read(f, g);
    close(f);
  end;

end.
