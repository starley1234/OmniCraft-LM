$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 29.25;             // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[81.406, 42.798], [60.07, 59.99], [50.312, 85.595], [27.367, 70.616], [0, 69.248], [7.156, 42.798], [0, 16.347], [27.367, 14.979], [50.312, 0], [60.07, 25.605]];  // primary outline, 10 points, counter clockwise
void_1 = [[40.332, 43.561], [39.834, 44.858], [38.923, 45.906], [37.708, 46.58], [36.336, 46.797], [34.972, 46.532], [33.782, 45.816], [32.907, 44.737], [32.455, 43.423], [32.479, 42.034], [32.977, 40.737], [33.888, 39.689], [35.103, 39.015], [36.476, 38.798], [37.839, 39.063], [39.03, 39.779], [39.904, 40.858], [40.357, 42.172]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
