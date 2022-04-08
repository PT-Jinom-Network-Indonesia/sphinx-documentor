# Tentang sphinx-php-documentation
Sphinx php documentation merupakan sebuah tools untuk generate dokumentasi php. Tools ini dibuat dengan menggunakan docker dan telah dibuatkan docker image untuk memudahkan dalam proses instalasi.

# Instalasi
Yang perlu di siapkan untuk menginstall sphinx-php-documentation adalah :
-   [Docker](https://docs.docker.com/get-docker/)

Cara instalasi :
- Pull image sphinx-php-documentation
    ```
    docker pull hendrapgpyph/sphinx-php-documentation
    ```
- Jalankan perintah docker-run berikut untuk membuat container
    ```
    docker run --name {NamaContainer} --mount src="{Lokasi_kumpulan_project}",dst=/project,type=bind -it hendrapgpyph/sphinx-php-documentation /bin/bash
    ```
    >**NamaContainer** : isi dengan nama container yang kamu inginkan \
    **Lokasi_kumpulan_project** : isi dengan folder yang berisi kumpulan project kamu. contoh : /Applications/XAMPP/xamppfiles/htdocs
-   Container berhasil di buat
 
# Getting started
Menjalankan Container :
-   Untuk menjalankan container jalankan perintah berikut untuk melihat ID container dari dokumentasi yang dibuat
    ```
    docker ps -a
    ```
    cari nama containermu dan copy CONTAINER ID tersebut
-   Kemudian jalankan perintah berikut untuk masuk ke bash container kamu
    ```
    docker exec -it {CONTAINER_ID} /bin/bash
    ```

# Generate Dokumentasi
-   Pilih project yang ingin dibuatkan dokumentasi dengan menjalankan perintah berikut
    ```
    doc-select
    ```
    Dan masukkan nama direktori project yang kamu tuju dan bahasa pemrogramannya
-   Jalankan perintah doc-init untuk menginstall sphinx documentation ke dalam projectmu
    ```
    doc-init
    ```
-   Setelah ini, jalankan perintah doc-generate untuk generate dokumentasi secara otomatis
    ```
    doc-generate
    ```

## PHP
-   Buka folder project laravelmu, pada bagian routes/web.php tambahkan code berikut :
    ```php
    Route::get('/documentation', function(){
        return redirect()->to('/documentation/contents.html');
    });

    Route::get('/documentation/{url}', function ($url) {
        if($url == "logout"){
            Auth::logout();
            return redirect()->to('/');
        }
        if(!Storage::disk('local-docs')->get($url)) {
            return redirect("/documentation/contents.html");
        }
        $resp = response(Storage::disk('local-docs')->get($url));
        $resp->header('content-type', GuzzleHttp\Psr7\MimeType::fromFilename($url));
        return $resp;   

    })->where('url', '(.*)')->middleware("auth");
    ```
-   Tambahkan pada file **config/filesystems.php** pada bagian **disks** dengan code sebagai berikut :
    ```php
    'disks' => [
        ...
       
        'local-docs' => [
            'driver' => 'local',
            'root' => storage_path('local-docs'),
        ],

    ],
    ```
-   Dokumentasi berhasil di install, anda dapat membuka hasil dokumentasi dengan menjalankan route : /documentation


## Javascript
Untuk Dokumentasi javascript kamu perlu menambahkan dockblock seperti berikut pada setiap file / module

```javascript
/**
 * Module helloworld
 * @module helloworld
 */

/**
 * Say hello
 * @param {string} name name
 * @memberof helloworld
 */
function say_hello(name = "") {
    console.log(`Hello, ${name}`);
}
```

Selanjutnya sesuaikan kembali source project javascriptnya pada file `jsdoc.json` 

```javascript
{
  ...
  "source": {
    "include": [
      "../src" // source dimana tempat file javascript yang akan didokumentasikan
    ]
  }
  ...
}

```

# Commands
-   Memilih/ganti project
    ```
    doc-select
    ```
-   Menginstall dokumentasi pada project
    ```
    doc-init
    ```
-   Generate dokumentasi
    ```
    doc-generate  
    ```
-   Menampilkan project yang sedang aktif / dipilih
    ```
    doc-show
    ```


