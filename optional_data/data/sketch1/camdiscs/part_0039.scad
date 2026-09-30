$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 12.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[34, 15.039], [33.715, 18.185], [33.272, 21.641], [32.466, 25.963], [30.256, 30.927], [25.894, 35.165], [19.837, 37.041], [13.183, 36.534], [6.062, 34.586], [2.034, 28.513], [0.917, 21.523], [0, 15.039], [1.092, 8.606], [4.67, 3.259], [10.2, 0.267], [16.132, 0], [21.055, 1.511], [24.675, 3.387], [27.594, 4.98], [30.203, 6.726], [32.254, 9.092], [33.554, 11.94]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
