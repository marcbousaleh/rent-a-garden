import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import 'mapbox-gl/dist/mapbox-gl.css';
import $ from 'jquery';
initMapbox();

$(function () {
  $('[data-toggle="tooltip"]').tooltip();
})
