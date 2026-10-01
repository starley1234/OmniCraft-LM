$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: flanged bushing R18
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
flange_r = 18;            // flange radius
flange_h = 5;             // flange thickness
sleeve_r = 10;            // sleeve radius
total_h = 24;             // overall height
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
flange_d = 2 * flange_r;
sleeve_d = 2 * sleeve_r;

profile = [[4, 0], [18, 0], [18, 5], [10, 5], [10, 24], [4, 24]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
