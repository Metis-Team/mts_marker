let releases = HEMTT_RFS.join("releases");

let src = releases.join(HEMTT.project().prefix() + "-" + HEMTT.project().version().to_string() + ".zip");

if (src.exists()) {
    let dst = releases.join(HEMTT.project().name() + "_" + HEMTT.project().version().to_string_short() + ".zip");

    print("Moving archive to " + dst);
    if (!src.move(dst)) {
        fatal("Failed to rename " + src + " to " + dst);
    }
} else {
    warn("Cannot rename archive. File " + src + " does not exist!");
}
