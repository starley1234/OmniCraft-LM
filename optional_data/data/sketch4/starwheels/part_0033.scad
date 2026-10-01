$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 29.25;             // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[42.798, 81.406], [25.605, 60.07], [0, 50.312], [14.979, 27.367], [16.347, 0], [42.798, 7.156], [69.248, 0], [70.616, 27.367], [85.595, 50.312], [59.99, 60.07]];  // primary outline, 10 points, counter clockwise
void_1 = [[47.706, 37.36], [47.083, 38.981], [45.944, 40.291], [44.425, 41.133], [42.71, 41.405], [41.006, 41.074], [39.517, 40.179], [38.424, 38.83], [37.859, 37.188], [37.889, 35.452], [38.512, 33.831], [39.651, 32.52], [41.17, 31.678], [42.885, 31.407], [44.589, 31.738], [46.078, 32.632], [47.171, 33.982], [47.736, 35.624]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
