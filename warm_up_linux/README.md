
Vì đây là file elf nên muốn debug trên IDA thì ta phải remote debug

E học theo cách debug trên youtube: https://www.youtube.com/watch?v=vMr7Zym6hEI

Đầu tiên bên trái là các function của file, ta bấm vào hàm main


![Screenshot (19)](https://user-images.githubusercontent.com/122852491/226811890-f035e10f-7399-4f89-ad19-f65eb2199a2e.png)


Bấm F5 để xem Pseudocode ( Code giả C):

![image](https://user-images.githubusercontent.com/122852491/226812523-e18c6c00-4d68-4475-bb3c-606e5fce325b.png)

![image](https://user-images.githubusercontent.com/122852491/226812646-e8b642dc-c84f-4edb-91ef-1d8be8ecd7e7.png)

Ta thấy trong điều kiện if strlen(s) == 25, tức là xâu s dài 25 kí tự.

![image](https://user-images.githubusercontent.com/122852491/226812773-d2ea78b8-1b4f-49d0-8eec-80e6848ed3a7.png)

Theo định nghĩa: Hàm void srand(unsigned int seed) cung cấp seed cho bộ sinh số ngẫu nhiên được sử dụng bởi hàm rand.

Vì tham số truyền vào là hằng số nên v10 không đổi.

![image](https://user-images.githubusercontent.com/122852491/226812981-dbb33d03-8d83-40dc-8004-945ec3e34f10.png)

Ta thấy, trong điều kiện của while thì (v5 <= 9) mà để (v5  & 1 == 0) thì v5 chẵn, tức là v5 sẽ thuộc {0,2,4,6,8}, tức là v5 sẽ có 5 giá trị

![image](https://user-images.githubusercontent.com/122852491/226819022-aedc20ba-0a9e-431b-bda7-7c437ffec2a2.png)

Đến đoạn này, ta thấy *((_BYTE *)&v12[8] + i) lúc đầu gán cho s[dword_601080[i]], sau đó ở vòng for tiếp theo s[j] = *((_BYTE *)&v12[8] + i) xor LOBYTE(v12[j / 5]), tức là s[j] = s[dword_601080[i]] xor LOBYTE(v12[j / 5]). 

Hiểu nôm na, xâu s ban đầu chính là flag ta cần tìm, sẽ bị xáo vị trí bằng cách thay thế các phần tử tại vị trí i bởi các phần tử tại vị trí dword_601080[i], dword_601080 ở đây là 1 mảng khác cho sẵn với mục đích để xáo trộn vị trí các phần tử trong xâu s.

![image](https://user-images.githubusercontent.com/122852491/226820662-7ff59eae-d94b-4e05-ae84-d74b55620db4.png)
          Các phần tử trong mảng dword_601080
          
Đến vong for tiếp theo sẽ mã hóa xâu s bằng cách xor các phần tử trong xâu s đã hoán vị trước đó với các phần tử trong mảng v12. Để xem các phần tử trong v12, chúng ta sẽ đặt breakpoint và debug.
![223756173-2e864180-b031-443c-a0ca-b5ff2916c45e](https://user-images.githubusercontent.com/122852491/226821671-fd577b3e-602c-41f8-b29b-1a3a136e7e10.png)

Vì chỉ xor với v12[j/5] với j chạy trong khoảng 0-> 24, vậy sẽ chỉ xor đến 5 phần tử đầu của mảng v12, là 0x0E, 0x4A, 0x79, 0x05,0x66.

![image](https://user-images.githubusercontent.com/122852491/226822040-747742fc-9ab8-4a02-863a-2d91932dd5c0.png)

Ở vòng for thứ 3 sẽ viết đoạn message được mã hóa vào file message. Như vậy, để ra được flag, ta cần phải xor đoạn message được mã hóa với v12[j/5] thì ra được xâu s đã hoán vị, từ đó lại duyệt thêm 1 vòng for nữa để ra được flag ban đầu.


![image](https://user-images.githubusercontent.com/122852491/226822927-170e5830-0c6d-49f4-914f-ee7b8d974987.png)
![image](https://user-images.githubusercontent.com/122852491/226823141-5845613b-5e6f-4341-8ce8-bee12f676d44.png)


* Flag: kcsctrainning{g00d_j0b!!} 
