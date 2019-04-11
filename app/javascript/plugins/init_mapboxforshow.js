import mapboxgl from 'mapbox-gl';

// show
const mapElementForShow = document.getElementById('map');

const buildMapForShow = () => {
  mapboxgl.accessToken = mapElementForShow.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10'
  });
};

const addMarkerToMapForShow = (map, marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
};


const fitMapToMarkerForShow = (map, marker) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ marker.lng, marker.lat ])
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapboxForShow = () => {
  if (mapElementForShow) {
    const map = buildMapForShow();
    console.log(mapElementForShow.dataset)
    const marker = JSON.parse(mapElementForShow.dataset.markers);
    console.log(marker);
    addMarkerToMapForShow(map, marker);
    fitMapToMarkerForShow(map, marker);

    // const myMarker = fetchMyCoordinates();
    // addMarkerToMapForShow(map, myMarker);
    // fitMapToMarkerForShow(map, myMarker);
  }
};

// const fetchMyCoordinates = () => {
//   var marker = {}
//   navigator.geolocation.getCurrentPosition((data) => {
//     console.log('mylocation')
//     const lat = data.coords.latitude;
//     const lng = data.coords.longitude;

//     // marker = {lat: lat, lng: lng}
//   });
//   return marker

// };


export { initMapboxForShow };
