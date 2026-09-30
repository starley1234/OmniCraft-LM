$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 13.0 mm, lift 4.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[30, 13.731], [29.434, 17.771], [27.94, 21.68], [25.486, 25.412], [21.809, 28.532], [17, 30.209], [11.769, 29.829], [7.008, 27.485], [3.247, 23.724], [0.832, 18.985], [0, 13.731], [0.902, 8.501], [3.669, 4.046], [7.853, 1.142], [12.538, 0], [17, 0.209], [21.04, 1.298], [24.641, 3.214], [27.517, 6.09], [29.364, 9.714]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
