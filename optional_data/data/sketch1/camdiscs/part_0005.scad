$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 10.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[40, 17.685], [39.441, 22.377], [38.191, 27.269], [35.93, 32.729], [31.614, 38.042], [25, 41.38], [17.332, 41.286], [10.305, 37.91], [4.775, 32.38], [1.224, 25.41], [0, 17.685], [1.399, 10.017], [5.831, 3.758], [12.419, 0.368], [19.254, 0], [25, 1.38], [29.692, 3.244], [33.817, 5.55], [37.135, 8.868], [39.266, 13.05]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
