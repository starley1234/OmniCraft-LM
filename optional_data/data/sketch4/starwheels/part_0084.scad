$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 21;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[29.248, 57.029], [20.136, 45.949], [5.793, 45.734], [8.774, 31.702], [0, 20.353], [12.829, 13.936], [16.231, 0], [29.248, 6.029], [42.264, 0], [45.666, 13.936], [58.496, 20.353], [49.721, 31.702], [52.703, 45.734], [38.359, 45.949]];  // primary outline, 14 points, counter clockwise
void_1 = [[34.156, 27.983], [33.534, 29.604], [32.394, 30.915], [30.876, 31.757], [29.161, 32.028], [27.456, 31.697], [25.968, 30.803], [24.875, 29.453], [24.309, 27.811], [24.34, 26.075], [24.962, 24.454], [26.101, 23.143], [27.62, 22.301], [29.335, 22.03], [31.04, 22.361], [32.528, 23.256], [33.621, 24.605], [34.186, 26.247]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
