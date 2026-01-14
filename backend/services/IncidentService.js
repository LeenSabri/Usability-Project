const incidents = [];

function saveIncident({ sender, childId, message, decision }) {
  const incident = {
    id: incidents.length + 1,
    sender,
    childId,
    message,
    decision,
    timestamp: new Date().toISOString()
  };

  incidents.push(incident);
  console.log("📁 Incident saved:", incident);

  return incident;
}

function getIncidentsByChild(childId) {
  return incidents.filter(i => i.childId === childId);
}

module.exports = {
  saveIncident,
  getIncidentsByChild
};
