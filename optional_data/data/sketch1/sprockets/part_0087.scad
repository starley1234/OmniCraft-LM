$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[48.488, 22.606], [53.655, 29.503], [46.614, 36.073], [46.74, 44.69], [37.183, 45.866], [32.22, 52.912], [23.796, 48.246], [15.639, 51.029], [11.567, 42.303], [3.333, 39.76], [5.167, 30.307], [0, 23.409], [7.041, 16.84], [6.915, 8.222], [16.472, 7.046], [21.435, 0], [29.859, 4.666], [38.016, 1.883], [42.088, 10.609], [50.322, 13.152]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
