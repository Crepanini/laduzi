import "bootstrap";

import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';
import { initMapboxForShow } from '../plugins/init_mapboxforshow';

initMapbox();
initMapboxForShow();

// import { make_copy_button } from '../plugins/init_copytoclipboard';
// make_copy_button();
