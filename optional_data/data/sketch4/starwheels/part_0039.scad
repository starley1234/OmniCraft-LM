$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 21;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 29.248], [11.08, 20.136], [11.295, 5.793], [25.327, 8.774], [36.676, 0], [43.093, 12.829], [57.029, 16.231], [51, 29.248], [57.029, 42.264], [43.093, 45.666], [36.676, 58.496], [25.327, 49.721], [11.295, 52.703], [11.08, 38.359]];  // primary outline, 14 points, counter clockwise
void_1 = [[33.927, 30.011], [33.429, 31.308], [32.517, 32.356], [31.302, 33.03], [29.93, 33.247], [28.567, 32.982], [27.376, 32.267], [26.502, 31.187], [26.049, 29.874], [26.073, 28.485], [26.571, 27.188], [27.483, 26.139], [28.698, 25.466], [30.07, 25.248], [31.433, 25.514], [32.624, 26.229], [33.498, 27.309], [33.951, 28.622]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
