$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 6.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[32.5, 12.522], [32.135, 15.645], [31.263, 18.797], [29.835, 22.141], [27.413, 25.47], [23.73, 28.029], [19.136, 28.968], [14.45, 27.96], [10.367, 25.37], [7.199, 21.713], [3.337, 17.856], [0, 12.522], [3.417, 7.213], [7.708, 3.659], [11.498, 0.98], [15.781, 0], [19.745, 0.314], [23.12, 1.253], [26.082, 2.49], [28.703, 4.209], [30.754, 6.575], [32.054, 9.423]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
