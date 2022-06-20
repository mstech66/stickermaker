'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "f7c102d04a6ca1b6412b403cda6f758a",
"manifest.json": "06d9db7790e2f06280f44eb853c28868",
"version.json": "fee9fc748789a915d5472bcd5ccad01a",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"index.html": "3b913e79ab7c2fa057a2ee6226176db9",
"/": "3b913e79ab7c2fa057a2ee6226176db9",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/AssetManifest.json": "b34117358bec623b6ed6587401623ec7",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/assets/22_Cuppy_bye.webp": "070fe59dbe27ed98f9f0f6feca6cbcd3",
"assets/assets/08_Cuppy_lovewithmug.webp": "bfa729a7f4b7a9e9bd3dd729b911dbd0",
"assets/assets/23_Cuppy_greentea.webp": "6f3e4ab0ffbb0e6b763b22786fa3f819",
"assets/assets/14_Cuppy_weird.webp": "5d445e61508298b08683073e9f2e11bb",
"assets/assets/05_Cuppy_cry.webp": "1250b162c2b7471b25331b1e1267340c",
"assets/assets/tray_Cuppy.png": "b36d6c902e01eeebce88286b6cd903b4",
"assets/assets/10_Cuppy_hmm.webp": "3dc25e82eef62b6cd3a60e609e43d52e",
"assets/assets/07_Cuppy_hate.webp": "4152e845b69059c11599a0a8963a20f1",
"assets/assets/16_Cuppy_angry.webp": "54f307a97a6a838c61941573c0b08dd8",
"assets/assets/13_Cuppy_curious.webp": "f2e6376bdf97b0c9cfe9f26925f05214",
"assets/assets/01_Cuppy_smile.webp": "bdf8837d03789c715a5bb6f00207ee2f",
"assets/assets/25_Cuppy_battery.webp": "14ebf30cd30919c551ce32983dd0c2b6",
"assets/assets/11_Cuppy_upset.webp": "fde636167a5c62e3503002d0cb6514a4",
"assets/assets/fonts/ProductSans-Regular.ttf": "ad656da8058c1cdfd68f1e95e574dc0e",
"assets/assets/04_Cuppy_sad.webp": "b7cceb42673bf7bc81acef94f8442108",
"assets/assets/24_Cuppy_phone.webp": "dfb2092ea98b7993d7c7986383a88e32",
"assets/assets/whatsapp.png": "c85f689b7a6ff320ece2a0bc67831002",
"assets/assets/17_Cuppy_tired.webp": "d813f4fff8a3b3235df5072d6c9c5904",
"assets/assets/lottie/add_close.json": "f701f2c25d5b1974b37a21d56ce146a1",
"assets/assets/20_Cuppy_disgusting.webp": "35837c1b931fd016249c9fb819605917",
"assets/assets/02_Cuppy_lol.webp": "c203c454b2d1983f31844fa1f139c40e",
"assets/assets/15_Cuppy_bluescreen.webp": "559ffeaa35320ffbd275a4e26be97dcf",
"assets/assets/19_Cuppy_shine.webp": "3d27d04222055bf3ca5772ad42565a24",
"assets/assets/09_Cuppy_lovewithcookie.webp": "e21e76254e746260758014061b60dc51",
"assets/assets/03_Cuppy_rofl.webp": "80e1c56977b8fc8d475160f95a25a642",
"assets/assets/12_Cuppy_angry.webp": "e354cbbd81d1ff70505a1dcbec8b9af8",
"assets/assets/06_Cuppy_love.webp": "da04cb2da2f4764a7b3c4edaf3aea049",
"assets/assets/images/google-play-badge.png": "fd310f7613e03f5a846e0f64bdd55f3a",
"assets/assets/images/deviceart.png": "e7e69023e913d51fd6901666a414d540",
"assets/assets/18_Cuppy_workhard.webp": "895d4b846aa34eda2c6761a0d4d94e2a",
"assets/assets/21_Cuppy_hi.webp": "e0153aa34d32eff023d1305ff0063f9f",
"assets/NOTICES": "f3aa0836434d98251dff3808acf01b48",
"assets/FontManifest.json": "bc75ffa79873fc101d6088f98ecf89a2",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
