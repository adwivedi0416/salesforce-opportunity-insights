public with sharing class OpportunityScoreCalculator {

    public class ScoreResult {
        @AuraEnabled public Integer score;
        @AuraEnabled public String riskLevel;
        @AuraEnabled public String recommendation;
    }

    @AuraEnabled(cacheable=true)
    public static ScoreResult calculateScore(Id oppId) {
        Opportunity opp = [
            SELECT Amount, StageName, CloseDate, LeadSource
            FROM Opportunity
            WHERE Id = :oppId
            LIMIT 1
        ];
        Integer score = 0;
        if (opp.Amount != null) {
            if (opp.Amount > 100000) score += 40;
            else if (opp.Amount > 50000) score += 30;
            else if (opp.Amount > 20000) score += 20;
            else score += 10;
        }
        Map<String, Integer> stageMap = new Map<String, Integer>{
            'Prospecting' => 5,
            'Qualification' => 10,
            'Proposal/Price Quote' => 20,
            'Negotiation/Review' => 30,
            'Closed Won' => 40
        };
        if (stageMap.containsKey(opp.StageName)) {
            score += stageMap.get(opp.StageName);
        }
        if (opp.CloseDate != null) {
            Integer daysToClose = opp.CloseDate.daysBetween(Date.today());
            if (daysToClose < 15) score += 20;
            else if (daysToClose < 30) score += 10;
            else score += 5;
        }
        if (opp.LeadSource == 'Web') score += 10;
        else if (opp.LeadSource == 'Partner Referral') score += 15;
        else score += 5;

        String risk;
        String suggestion;
        if (score > 80) {
            risk = 'Low';
            suggestion = 'Follow up with a strong proposal and close quickly.';
        } else if (score > 50) {
            risk = 'Medium';
            suggestion = 'Strengthen engagement and clarify customer objections.';
        } else {
            risk = 'High';
            suggestion = 'Re-evaluate opportunity fit or escalate for support.';
        }

        ScoreResult result = new ScoreResult();
        result.score = score;
        result.riskLevel = risk;
        result.recommendation = suggestion;
        return result;
    }
}