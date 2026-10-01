$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 15;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[29.248, 57.029], [22.74, 40.544], [5.793, 45.734], [14.624, 30.367], [0, 20.353], [17.52, 17.677], [16.231, 0], [29.248, 12.029], [42.264, 0], [40.975, 17.677], [58.496, 20.353], [43.872, 30.367], [52.703, 45.734], [35.756, 40.544]];  // primary outline, 14 points, counter clockwise
void_1 = [[35.138, 28.174], [34.391, 30.119], [33.024, 31.692], [31.201, 32.702], [29.143, 33.028], [27.098, 32.631], [25.311, 31.557], [24, 29.938], [23.322, 27.968], [23.358, 25.884], [24.105, 23.939], [25.472, 22.366], [27.294, 21.356], [29.353, 21.03], [31.398, 21.428], [33.184, 22.501], [34.496, 24.12], [35.174, 26.09]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
