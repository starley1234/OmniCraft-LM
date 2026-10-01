$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[28.532, 54.271], [17.07, 40.046], [0, 33.541], [9.986, 18.245], [10.898, 0], [28.532, 4.771], [46.165, 0], [47.077, 18.245], [57.063, 33.541], [39.994, 40.046]];  // primary outline, 10 points, counter clockwise
void_1 = [[33.44, 25.225], [32.818, 26.846], [31.678, 28.156], [30.16, 28.998], [28.444, 29.27], [26.74, 28.938], [25.251, 28.044], [24.159, 26.695], [23.593, 25.053], [23.624, 23.316], [24.246, 21.695], [25.385, 20.385], [26.904, 19.543], [28.619, 19.271], [30.324, 19.603], [31.812, 20.497], [32.905, 21.846], [33.47, 23.488]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
