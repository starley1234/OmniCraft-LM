$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[42.798, 81.406], [26.927, 58.249], [0, 50.312], [17.119, 28.062], [16.347, 0], [42.798, 9.406], [69.248, 0], [68.476, 28.062], [85.595, 50.312], [58.668, 58.249]];  // primary outline, 10 points, counter clockwise
void_1 = [[48.687, 37.551], [47.941, 39.496], [46.573, 41.069], [44.751, 42.079], [42.693, 42.405], [40.647, 42.007], [38.861, 40.934], [37.55, 39.315], [36.871, 37.344], [36.908, 35.261], [37.655, 33.316], [39.022, 31.743], [40.844, 30.733], [42.902, 30.407], [44.948, 30.804], [46.734, 31.878], [48.045, 33.497], [48.724, 35.467]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
