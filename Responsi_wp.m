opts = detectImportOptions('Real estate valuation data set.xlsx'); %untuk mendeteksi file yang ditunjuk
opts.SelectedVariableNames = ([3:5,8]); %Menunjuk variabel 1 & 3-8
data = readmatrix('Real estate valuation data set.xlsx',opts); %membaca file .xlsx

data = data(1:50,:); %menampilkan jumlah baris dan kolom dengan spesific
k = [0,0,1,0]; %atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
w = [3,5,4,1]; %Nilai bobot tiap kriteria (1= sangat buruk, 2=buruk, 3= cukup, 4= tinggi, 5= sangat tinggi) 

%tahapan pertama, perbaikan bobot
[m n]=size (data); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n
    if k(j)==0 %perulangan untuk kriteria 0 
        w(j)=-1*w(j); %kriteria 0 akan dirubah nilai nya menjadi (-1( 
    end;
end;
for i=1:m
    S(i)=prod(data(i,:).^w); %S didapat dari penjumlahan seluruh data alternatif tiap baris dimana tiap data dipangatkan dengan bobot yang sudah dikali kriteria
end; 

%tahapan ketiga, proses perangkingan
V= S/sum(S); %V didapat dari nilai s dibagi angka tetinggi S

Vtranspose=V.';
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
data2 = readmatrix('Real estate valuation data set.xlsx',opts);
data2 = data2(1:50,:); %variabel baru menunjuk data3 dari kolom 1-20 dengan baris semua 
data2 = [data2 Vtranspose]; %mengkalikan matriks data2 dan Vtranspose
data2 = sortrows(data2,-2); %untuk men sort data2 dari besar ke kecil
data2 = data2(1:5,1); %menunjuk data2 dari kolom 1-20

disp ('Investasi jangka panjang yang cocok ialah')
disp (data2)