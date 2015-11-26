#!/usr/bin/perl -w
  # remd: conv2ascii.pl est un script qui converti du texte français avec accents
  # en texte ascii et vice versa, le nom du fichier peut etre entrer en argument
  # et le nom de sorti (par defaut .html) aussi
  # usage: accent2ascii.pl [Options] nom_de_source [nom_de_cible]
  # Option:
  #    -t pour laisser le fichier de sortie en mode texte (.log)
  #    -b pour binmode # ca sert un max
  #    -o pour outout auquel cas il faut entrer un nom pour la cible
  # ou conv2ascii.pl nom_de_source
  # Alain Adelmar
  # Ce script fonctionne à merveille avec le fichier à traiter comme argument.
  # C'est à dire: accent2ascii
  # a revoir si on veut faire echange source cible (garder le nom)
  # $ID:
  
  # use strict;
  # use File::Copy;
  # use warnings;
  
  # utilisation de la date/heure pour maitenant et pour file X
  use DateFrench;
  our $format_affichage = 2;
  our $opt_date_file = 2;
  our $fr_date_now = maintenant("$format_affichage");
  print "$fr_date_now\n";
  
  use Cwd;
  my $dir= cwd;
  
  my $lx = "x" x 20;
  my $argv = my $f = my $fout = my $resp = "";
  my $moi = "alain Adelmar";
  my $recap_lbl= "$0 écris par $moi \nle 21 Avril 2008\nexecuter $fr_date_now\n";
  
  # traitement argument - fichier a traiter et verif validité
  
  if (@ARGV) {
    if ($ARGV[0] =~ /^-/) {
      $ARGV[0] =~ s/-()/($1)/;
      ($argv = $ARGV[0]); # assigne $argv
    # ($argv = "b") if ($ARGV[0]=~ /^b/);   # pour b pour binaire
    # ($argv = "u") if ($ARGV[0]=~ /^u/);   # pour u
    # ($argv = "l") if ($ARGV[0]=~ /^l/);   # pour latin1 => utf8
    # ($argv = "o") if ($ARGV[0]=~ /^o/);   # pour output (c.a.d: fichier differant)
      if($argv=~ /o/) {
        if ($ARGV[2] ne "") {
          $fout = $ARGV[2];
          $f = $ARGV[1];
          print "f vaut $f (source)\nfout vaut $fout (cible)\net est considerer comme argv2\n";
          }
        else {
          print "si vous prennez l option -o il faut indiquer le fichier cible\npar defaut sorti_" . $ARGV[1] . "\n";
          print "usage: $0 [-blo] [nom_de_la_source] ([nom_de_la_cible] pour option -o)\n";
          chomp($fout = <STDIN>);
          }
        }
      if ($ARGV[1] ne "") {
        $f = $ARGV[1];
        &veriff;
        }
      }
    else {
      $f = $ARGV[0];
      &veriff;
      }
    }
  else {
    print "$lx\nusage: morrowin.pl [-cou] [fichier_a_traiter] \n(made by $moi)\n";
    #---------demander quel fichier traiter et verifier si il existe
    print "$lx\n";
    print "Indiquez le fichier a traiter:\n";
    chomp($f =<STDIN>);
    &veriff;
    }
  
  
  # création d'un fichier de sortie--------------
  if ($argv =~ /o/) {
    ($fout= "$dir/$fout") if(!($fout =~ /\/|\\/));
    print "désirez vous avoir $fout comme fichier cible?";
    my $resp = <STDIN>;
    if($resp=~ /^n/i) {
      print "veuillez recommencer tout en indiquant le nom_du_fichier_cible oupath_et_le_nom_du_fichier_cible\n";
      }
    }
  else {
    $fout = "sorti_" . "$rootfile";
    }
  
  #----------------------------ici c'est bien -------------------
  # ouverture du fichier en lecture seule
  open F, "$f" or die "ouverture de $f impossible $!";
  if ($argv =~ /b/) {
    binmode F;
    }
  @contenu = <F>;
  close F || die "Fermeture de $f impossible $!";
  
  #foreach $l(@contenu) {
  
  foreach (@contenu) {
    s/à/\&agrave;/g;
    s/â/\&acirc;/g;
    s/ä/\&auml;/g;
    s/á/\&aacute;/g;
    s/ã/\&atilde;/g;
    s/å/\&aring;/g;
    s/é/\&eacute;/g;
    s/è/\&egrave;/g;
    s/ê/\&ecirc;/g;
    s/ë/\&euml;/g;
    s/î/\&icirc;/g;
    s/ï/\&iuml;/g;
    s/ô/\&ocirc;/g;
    s/ö/\&ouml;/g;
    s/û/\&ucirc;/g;
    s/ü/\&uuml;/g;
    s/ŷ/\&ycirc;/g;
    s/ÿ/\&yuml;/g;
    s/«/\&laquo;/g;
    s/»/\&raquo;/g;
    s/À/\&Agrave;/g;
    s/Á/\&Aacute;/g;
    s/Â/\&Acirc;/g;
    s/Ã/\&Atilde;/g;
    s/Ä/\&Auml;/g;
    s/Å/\&Aring;/g;
    s/Æ/\&AElig;/g;
    s/Ç/\&Ccedil;/g;
    s/È/\&Egrave;/g;
    s/É/\&Eacute;/g;
    s/Ê/\&Ecirc;/g;
    s/Ë/\&Euml;/g;
    s/Ì/\&Igrave;/g;
    s/Í/\&Iacute;/g;
    s/Î/\&Icirc;/g;
    s/Ï/\&Iuml;/g;
    s/Ð/\&ETH;/g;
    s/Ñ/\&Ntilde;/g;
    s/Ò/\&Ograve;/g;
    s/Ó/\&Oacute;/g;
    s/Ô/\&Ocirc;/g;
    s/Õ/\&Otilde;/g;
    s/Ö/\&Ouml;/g;
    s/×/\&times;/g;
    s/Ø/\&Oslash;/g;
    s/Ù/\&Ugrave;/g;
    s/Ú/\&Uacute;/g;
    s/Û/\&Ucirc;/g;
    s/Ü/\&Uuml;/g;
    s/Ý/\&Yacute;/g;
    s/Þ/\&THORN;/g;
    s/ß/\&szlig;/g;
    s/æ/\&aelig;/g;
    s/ç/\&ccedil;/g;
    s/ì/\&igrave;/g;
    s/í/\&iacute;/g;
    s/ð/\&eth;/g;
    s/ò/\&ograve;/g;
    s/ó/\&oacute;/g;
    s/õ/\&otilde;/g;
    s/÷/\&divide;/g;
    s/ø/\&oslash;/g;
    s/ù/\&ugrave;/g;
    s/ú/\&uacute;/g;
    s/ÿ/\&ytilde;/g;
    s/ý/\&yacute;/g;
    s/þ/\&thorn;/g;
    s/®/\&reg;/g;
    s/©/\&copy;/g;
    s/¢/\&cent;/g;
   push @nwline, $_;
  }
  
  #--------------------------------------------------------------
  
  if($fout eq "") {
    $rootfile = "log.log";
    }
  &logout;
  open FOUT, ">$fout" or die "Ouverture de $fout impossible $!";
  
  print FOUT @nwline;
  close FOUT || die "Fermeture de $fout impossible $!";
  
  if ($argv=~ /l/) {
    # system("iconv -f latin1 -t utf8 $fout");
    }
  
  
  sub veriff {
    if ($f !~ /\/|\\/) {
      $rootfile = $f;
      $f = "$dir\/$f";
      }
    else {
      $rootfile = $f;
      @pathf = split("\/", $rootfile);
      $rootfile = pop @pathf;
      }
    while (!(-f $f)) {
      print "Veuillez entrer un nom de fichier, et son path si ailleur que dans le $dir:\n";
      chomp ($f = <STDIN>);
      }
    }
  
  sub logout {
    my $fout= @_;
  
    $u= 0;
    while (-f $fout) {
      $u++;
      $fout = "$dir\/sorti_" . $u . "_$rootfile";
      }
    }
  
  END;