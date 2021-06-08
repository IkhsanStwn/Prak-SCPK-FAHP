namaLahan = {'kebun1' 'kebun2' 'kebun3' 'kebun4'};

data = [ 135 321 4170
    120 310 4000
    130 116 1500
    127 222 2890];

%batas kriteria
maksJumlahPohon = 136;
maksJumlahTandan = 346;
maksBeratTotal = 5000;

data(:,1) = data(:,1) / maksJumlahPohon;
data(:,2) = data(:,2) / maksJumlahTandan;
data(:,3) = data(:,3) / maksBeratTotal;

relasiAntarKriteria = [ 1     2     2
                          0     1     4
                          0     0     1];
                   
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};

[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)

if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Lahan, Skor Akhir, Kesimpulan')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Kurang';
        elseif ahp(i) < 0.7
            status = 'Cukup';
        elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        
        disp([char(namaLahan(i)), blanks(13 - cellfun('length',namaLahan(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
end
    