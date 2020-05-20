%p1 = [ 1 -1 -1 -1 -1 1 -1 1 1 1 1 -1 -1 1 1 1 1 -1 -1 1 1 1 1 -1 1 -1 -1 -1 -1 1];
   
%p2 = [ 1 1 1 1 1 1 -1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 1 1 1 1 1 1];

%p3 = [ -1 1 1 1 1 1 -1 1 1 -1 -1 -1 -1 1 1 -1 1 -1 1 -1 -1 1 1 -1 1 1 1 1 1 -1];

AudreyHep = imread("AudreyHepburn.jpg");
Audrey = double(AudreyHep);
AudreyP = reshape(Audrey, 75 * 75,1);

BillGates = imread("BillGates.jpg");
BillGray = rgb2gray(BillGates);
Bill = double(BillGray);
BillP = reshape(Bill, 75 * 75,1);

MrWhite = imread("MrWhite.jpg");
MrGray = rgb2gray(MrWhite);
Mr = double(MrGray);
MrP = reshape(Mr, 75 * 75,1);

SheldonCooper = imread("SheldonCooper.jpg");
SheldonGray = rgb2gray(SheldonCooper);
Sheldon = double(SheldonGray);
SheldonP = reshape(Sheldon, 75 * 75,1);

TaylorSwift = imread("TaylorSwift.jpg");
TaylorGray = rgb2gray(TaylorSwift);
Taylor = double(TaylorGray);
TaylorP = reshape(Taylor, 75 * 75,1);

T = [AudreyP BillP MrP SheldonP TaylorP];

%p1Norm = transpose(normc(transpose(p1)));
%p2Norm = transpose(normc(transpose(p2)));
%p3Norm = transpose(normc(transpose(p3)));

AudreyNorm = normc(AudreyP);
BillNorm = normc(BillP);
MrNorm = normc(MrP);
SheldonNorm = normc(SheldonP);
TaylorNorm = normc(TaylorP);

phebb =[AudreyNorm BillNorm MrNorm SheldonNorm TaylorNorm];

wHebb = T * transpose(phebb);

AudreyNormGN = awgn(AudreyNorm, 1, 10);
BillNormGN = awgn(BillNorm, 1, 10);
MrNormGN = awgn(MrNorm, 1, 10);
SheldonNormGN = awgn(SheldonNorm, 1, 10);
TaylorNormGN = awgn(TaylorNorm, 1, 10);

Tinput1 = wHebb * AudreyNormGN;
Tinput2 = wHebb * BillNormGN;
Tinput3 = wHebb * MrNormGN;
Tinput4 = wHebb * SheldonNormGN;
Tinput5 = wHebb * TaylorNormGN;

Toutput1 = reshape(Tinput1, [75, 75]);
Toutput2 = reshape(Tinput2, [75, 75]);
Toutput3 = reshape(Tinput3, [75, 75]);
Toutput4 = reshape(Tinput4, [75, 75]);
Toutput5 = reshape(Tinput5, [75, 75]);

RHebb = [corr2(AudreyP, Tinput1) corr2(AudreyP, Tinput2) corr2(AudreyP, Tinput3) corr2(AudreyP, Tinput4) corr2(AudreyP, Tinput5);
      corr2(BillP, Tinput1) corr2(BillP, Tinput2) corr2(BillP, Tinput3) corr2(BillP, Tinput4) corr2(BillP, Tinput5);
      corr2(MrP, Tinput1) corr2(MrP, Tinput2) corr2(MrP, Tinput3) corr2(MrP, Tinput4) corr2(MrP, Tinput5);
      corr2(SheldonP, Tinput1) corr2(SheldonP, Tinput2) corr2(SheldonP, Tinput3) corr2(SheldonP, Tinput4) corr2(SheldonP, Tinput5);
      corr2(TaylorP, Tinput1) corr2(TaylorP, Tinput2) corr2(TaylorP, Tinput3) corr2(TaylorP, Tinput4) corr2(TaylorP, Tinput5)];
disp(RHebb);

imshow(Toutput1);

pinv= [AudreyP; BillP; MrP; SheldonP; TaylorP;];
pinvtrans = transpose(pinv);

pinvt = inv(pinv * pinvtrans) * pinv;
winv = t * pinvt;

Tinvinput1 =  winv * p1invertNorm;
Tinvinput2 = winv * p2invertNorm;
Tinvinput3 = winv * p3invertNorm;

Tinvoutput1 = reshape(Tinput1, [6, 5]);
Tinvoutput2 = reshape(Tinput2, [6, 5]);
Tinvoutput3 = reshape(Tinput3, [6, 5]);

Rinv = [corr2(transpose(AudreyP), Tinvinput1) corr2(transpose(), Tinvinput2) corr2(transpose(p1), Tinvinput3);
      corr2(transpose(p2), Tinvinput1) corr2(transpose(p2), Tinvinput2) corr2(transpose(p2), Tinvinput3);
      corr2(transpose(p3), Tinvinput1) corr2(transpose(p3), Tinvinput2) corr2(transpose(p3), Tinvinput3); ];
%disp(Rinv);







