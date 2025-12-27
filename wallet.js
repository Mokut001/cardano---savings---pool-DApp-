async function connectWallet() {
    if (!window.cardano || !window.cardano.nami) {
        document.getElementById("status").innerText = "No CIP-30 wallet found!";
        return;
    }

    try {
        const api = await window.cardano.nami.enable();
        const addr = await api.getUsedAddresses();
        document.getElementById("status").innerText =
            "Wallet connected successfully!";
    } catch (err) {
        document.getElementById("status").innerText = "Connection failed!";
    }
}