function notifyParent(childId, incident) {
  // Placeholder for real notification (email / push / dashboard)
  console.log("📣 Parent notified");
  console.log({
    childId,
    incidentId: incident.id,
    message: incident.message,
    sender: incident.sender
  });
}

module.exports = {
  notifyParent
};
