$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 16.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[28.532, 54.271], [18.833, 37.619], [0, 33.541], [12.839, 19.172], [10.898, 0], [28.532, 7.771], [46.165, 0], [44.224, 19.172], [57.063, 33.541], [38.23, 37.619]];  // primary outline, 10 points, counter clockwise
void_1 = [[32.458, 25.034], [31.96, 26.331], [31.049, 27.379], [29.834, 28.053], [28.462, 28.27], [27.098, 28.005], [25.907, 27.289], [25.033, 26.21], [24.581, 24.896], [24.605, 23.507], [25.103, 22.21], [26.014, 21.162], [27.229, 20.488], [28.602, 20.271], [29.965, 20.536], [31.156, 21.252], [32.03, 22.331], [32.482, 23.645]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
