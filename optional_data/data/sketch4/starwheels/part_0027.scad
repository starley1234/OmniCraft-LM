$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[33.287, 63.316], [18.886, 48.137], [0, 39.131], [9.986, 20.745], [12.714, 0], [33.287, 3.816], [53.859, 0], [56.588, 20.745], [66.574, 39.131], [47.688, 48.137]];  // primary outline, 10 points, counter clockwise
void_1 = [[39.177, 29.46], [38.43, 31.406], [37.063, 32.978], [35.24, 33.989], [33.182, 34.315], [31.137, 33.917], [29.351, 32.844], [28.039, 31.224], [27.361, 29.254], [27.397, 27.171], [28.144, 25.225], [29.511, 23.653], [31.334, 22.642], [33.392, 22.317], [35.437, 22.714], [37.223, 23.787], [38.535, 25.407], [39.213, 27.377]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
