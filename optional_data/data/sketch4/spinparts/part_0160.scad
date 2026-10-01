$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: flanged bushing R24
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
flange_r = 24;            // flange radius
flange_h = 6;             // flange thickness
sleeve_r = 10;            // sleeve radius
total_h = 28;             // overall height
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
flange_d = 2 * flange_r;
sleeve_d = 2 * sleeve_r;

profile = [[5, 0], [24, 0], [24, 6], [10, 6], [10, 28], [5, 28]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
